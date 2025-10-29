import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/product_state_model.dart';
import '../../providers/product_state_notifier.dart';
import '../widgets/prodict_grid_view.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  final ProductStateProvider _productStateNotifier = ProductStateProvider(() {
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
      ref.read(_productStateNotifier.notifier).fetchProducts();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(_productStateNotifier.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductStateModel productStateModel = ref.watch(_productStateNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: switch (productStateModel) {
        ProductStateLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        ProductStateFailed() => const Center(
            child: Text("Failed Try again"),
          ),
        ProductStateSuccess(
          products: final products,
          isLoadingMore: final isLoadingMore,
          hasMore: final hasMore
        ) =>
          ProductGridView(
            products: products,
            scrollController: _scrollController,
            isLoadingMore: isLoadingMore,
            hasMore: hasMore,
          )
      },
    );
  }
}
