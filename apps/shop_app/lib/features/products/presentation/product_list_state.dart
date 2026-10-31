import '../../../core/failure.dart';
import '../domain/product.dart';

sealed class ProductListState {
  const ProductListState();
}

/// Also covers waiting for connectivity: the screen shows the offline view
/// while this state and an offline status coincide.
final class ProductListLoading extends ProductListState {
  const ProductListLoading();
}

final class ProductListData extends ProductListState {
  const ProductListData({
    required this.items,
    required this.hasMore,
    this.loadingMore = false,
    this.loadMoreError,
    this.refreshError,
  });

  final List<Product> items;
  final bool hasMore;
  final bool loadingMore;
  final Failure? loadMoreError;
  final Failure? refreshError;

  ProductListData copyWith({
    List<Product>? items,
    bool? hasMore,
    bool? loadingMore,
    Failure? loadMoreError,
    Failure? refreshError,
    bool clearLoadMoreError = false,
    bool clearRefreshError = false,
  }) {
    return ProductListData(
      items: items ?? this.items,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      loadMoreError: clearLoadMoreError
          ? null
          : loadMoreError ?? this.loadMoreError,
      refreshError: clearRefreshError
          ? null
          : refreshError ?? this.refreshError,
    );
  }
}

final class ProductListEmpty extends ProductListState {
  const ProductListEmpty();
}

final class ProductListError extends ProductListState {
  const ProductListError(this.failure);

  final Failure failure;
}
