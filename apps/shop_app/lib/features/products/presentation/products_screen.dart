import 'package:context_watch/context_watch.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../app/app_route.dart';
import '../../../core/core_providers.dart';
import '../../../core/failure.dart';
import '../../../core/provider_scope.dart';
import '../../auth/auth_providers.dart';
import '../domain/product.dart';
import 'product_detail_screen.dart';
import 'product_list_controller.dart';
import 'product_list_state.dart';
import 'widgets/product_card.dart';
import 'widgets/product_grid.dart';
import 'widgets/product_grid_skeleton.dart';
import 'widgets/products_header.dart';
import 'widgets/products_footer.dart';
import '../products_providers.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderBuilder(
      provider: productListControllerProvider,
      builder: (context, controller) => _ProductsView(controller: controller),
    );
  }
}

class _ProductsView extends StatefulWidget {
  const _ProductsView({required this.controller});

  final ProductListController controller;

  @override
  State<_ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<_ProductsView> {
  // Cards that already played their entrance, so scrolling back doesn't replay it.
  final _entered = <int>{};

  ProductListController get _controller => widget.controller;

  void _openDetail(Product product) {
    Navigator.of(context)
        .push(appRoute<void>((_) => ProductDetailScreen(product: product)));
  }

  bool _onScroll(ScrollNotification n) {
    if (n.metrics.axis == Axis.vertical && n.metrics.extentAfter < 900) {
      _controller.loadMore();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.watch(context);
    final online = context
        .read(connectivityStatusProvider)
        .online
        .watch(context);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          ProductsHeader(
            onTitleLongPress: () =>
                context.read(devPanelLauncherProvider)?.call(context),
            onLogout: () => context.read(authControllerProvider).signOut(),
          ),
          Expanded(
            child: OfflineGate(
              loading: state is ProductListLoading,
              online: online,
              child: FadeSwitcher(child: _body(state)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(ProductListState state) {
    return switch (state) {
      ProductListLoading() => const ProductGridSkeleton(
        key: ValueKey('loading'),
      ),
      ProductListError(:final failure) => PullToRefresh(
        key: const ValueKey('error'),
        onRefresh: _controller.load,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: ErrorView(
              title: failure is OfflineFailure
                  ? "You're offline"
                  : "Couldn't load products",
              message: failure.message,
              onRetry: _controller.load,
            ),
          ),
        ],
      ),
      ProductListEmpty() => PullToRefresh(
        key: const ValueKey('empty'),
        onRefresh: _controller.load,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyView(
              icon: LucideIcons.packageSearch,
              title: 'No products yet',
              message:
                  'The catalog is empty right now. Pull down to check again.',
              actionLabel: 'Refresh',
              onAction: _controller.load,
            ),
          ),
        ],
      ),
      ProductListData() => _dataBody(state),
    };
  }

  Widget _dataBody(ProductListData state) {
    return NotificationListener<ScrollNotification>(
      key: const ValueKey('data'),
      onNotification: _onScroll,
      child: PullToRefresh(
        onRefresh: _controller.refresh,
        slivers: [
          if (state.refreshError != null)
            SliverToBoxAdapter(
              child: RefreshNotice(failure: state.refreshError!),
            ),
          SliverPadding(
            padding: productGridPadding,
            sliver: SliverGrid.builder(
              gridDelegate: productGridDelegate,
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final product = state.items[index];
                final play = _entered.add(product.id);
                return FadeSlideIn(
                  key: ValueKey(product.id),
                  play: play,
                  delay: Duration(milliseconds: (index % 6) * 45),
                  child: ProductCard(
                    product: product,
                    onTap: () => _openDetail(product),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: ProductsFooter(
              loadingMore: state.loadingMore,
              hasMore: state.hasMore,
              error: state.loadMoreError,
              onRetry: _controller.retryLoadMore,
            ),
          ),
        ],
      ),
    );
  }
}
