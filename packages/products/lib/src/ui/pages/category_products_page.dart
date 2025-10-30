import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common/common.dart';

import '../../providers/product_list/product_state_model.dart';
import '../../providers/product_list/product_state_notifier.dart';
import '../widgets/prodict_grid_view.dart';

class CategoryProductsPage extends ConsumerStatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryProductsPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  ConsumerState createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends ConsumerState<CategoryProductsPage> {
  final ProductStateProvider _productStateProvider = ProductStateProvider(() {
    return ProductStateNotifier();
  });
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _loadProducts() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(_productStateProvider.notifier)
          .fetchProductsByCategory(widget.categoryId);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(_productStateProvider.notifier)
          .loadMoreCategory(widget.categoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(_productStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: switch (productState) {
        ProductStateLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        ProductStateFailed(:final message) => ErrorRetryWidget(
            message: message,
            onRetry: _loadProducts,
          ),
        ProductStateSuccess(
          products: final products,
          isLoadingMore: final isLoadingMore,
          hasMore: final hasMore
        ) =>
          products.isEmpty
              ? const Center(
                  child: Text("No products in this category"),
                )
              : ProductGridView(
                  products: products,
                  scrollController: _scrollController,
                  isLoadingMore: isLoadingMore,
                  hasMore: hasMore,
                ),
      },
    );
  }
}
