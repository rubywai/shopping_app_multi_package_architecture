import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/product_service.dart';
import 'product_state_model.dart';

typedef ProductStateProvider
    = NotifierProvider<ProductStateNotifier, ProductStateModel>;

class ProductStateNotifier extends Notifier<ProductStateModel> {
  final ProductService _productService = ProductService();
  static const int _perPage = 20;

  @override
  ProductStateModel build() {
    return ProductStateLoading();
  }

  Future<void> fetchProducts() async {
    state = ProductStateLoading();
    try {
      final products = await _productService.getProducts(
        page: 1,
        perPage: _perPage,
      );
      state = ProductStateSuccess(
        products: products,
        currentPage: 1,
        hasMore: products.length >= _perPage,
      );
    } catch (e) {
      state = ProductStateFailed(message: e.toString());
    }
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! ProductStateSuccess) return;
    if (!currentState.hasMore || currentState.isLoadingMore) return;

    // Set loading more flag
    state = currentState.copyWith(isLoadingMore: true);

    try {
      final nextPage = currentState.currentPage + 1;
      final newProducts = await _productService.getProducts(
        page: nextPage,
        perPage: _perPage,
      );

      // Append new products to existing list
      final allProducts = [...currentState.products, ...newProducts];

      state = ProductStateSuccess(
        products: allProducts,
        currentPage: nextPage,
        hasMore: newProducts.length >= _perPage,
        isLoadingMore: false,
      );
    } catch (e) {
      // Reset loading flag on error
      state = currentState.copyWith(isLoadingMore: false);
    }
  }
}
