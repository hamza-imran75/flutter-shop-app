import 'package:flutter/foundation.dart';

import '../../../core/connectivity_status.dart';
import '../../../core/failure.dart';
import '../domain/product_repository.dart';
import 'product_list_state.dart';

class ProductListController extends ValueNotifier<ProductListState> {
  ProductListController({required this.repository, required this.connectivity})
    : super(const ProductListLoading());

  static const pageSize = 20;

  final ProductRepository repository;
  final ConnectivityStatus connectivity;

  // Bumped by every first-page request. A response that arrives after a newer
  // request, or after dispose, is dropped.
  int _generation = 0;
  bool _refreshing = false;
  bool _disposed = false;

  /// Loads page 0 behind a loading state, waiting out any lost connectivity.
  Future<void> load() async {
    final generation = ++_generation;
    value = const ProductListLoading();
    try {
      final page = await retryWhenOnline(
        connectivity,
        () => repository.fetchPage(skip: 0, limit: pageSize),
      );
      if (!_isCurrent(generation)) return;
      value = page.items.isEmpty
          ? const ProductListEmpty()
          : ProductListData(items: page.items, hasMore: page.hasMore);
    } catch (e) {
      if (_isCurrent(generation)) value = ProductListError(e.asFailure());
    }
  }

  /// Pull to refresh. Keeps the list on screen and reports a failure inline.
  Future<void> refresh() async {
    final current = value;
    if (current is! ProductListData) return load();
    if (_refreshing) return;
    final generation = ++_generation;
    _refreshing = true;
    try {
      final page = await repository.fetchPage(skip: 0, limit: pageSize);
      if (!_isCurrent(generation)) return;
      value = page.items.isEmpty
          ? const ProductListEmpty()
          : ProductListData(items: page.items, hasMore: page.hasMore);
    } catch (e) {
      final latest = value;
      if (_isCurrent(generation) && latest is ProductListData) {
        value = latest.copyWith(
          loadingMore: false,
          refreshError: e.asFailure(),
        );
      }
    } finally {
      _refreshing = false;
    }
  }

  Future<void> loadMore() async {
    final current = value;
    if (current is! ProductListData ||
        _refreshing ||
        current.loadingMore ||
        !current.hasMore ||
        current.loadMoreError != null) {
      return;
    }
    final generation = _generation;
    value = current.copyWith(loadingMore: true, clearRefreshError: true);
    try {
      final page = await repository.fetchPage(
        skip: current.items.length,
        limit: pageSize,
      );
      if (!_isCurrent(generation)) return;
      value = current.copyWith(
        items: [...current.items, ...page.items],
        hasMore: page.hasMore,
        loadingMore: false,
      );
    } catch (e) {
      if (_isCurrent(generation)) {
        value = current.copyWith(
          loadingMore: false,
          loadMoreError: e.asFailure(),
        );
      }
    }
  }

  Future<void> retryLoadMore() {
    final current = value;
    if (current is ProductListData) {
      value = current.copyWith(clearLoadMoreError: true);
    }
    return loadMore();
  }

  bool _isCurrent(int generation) => !_disposed && generation == _generation;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
