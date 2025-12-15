import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/product_list_model.dart';
import '../data/service/product_service.dart';
import 'product_list_state_model.dart';

typedef ProductListProvider =
    NotifierProvider<ProductListNotifier, ProductListSateModel>;

class ProductListNotifier extends Notifier<ProductListSateModel> {
  final ProductService _productService = ProductService();
  @override
  ProductListSateModel build() {
    return ProductListLoadingState();
  }

  void loadProduct({int page = 1, int perPage = 10}) async {
    try {
      state = ProductListLoadingState();
      List<ProductListModel> products = await _productService.getProductList();
      state = ProductListSuccessState(
        products: products,
        currentPage: page,
        hasMore: products.length >= perPage,
        isLoadingMore: false,
      );
    } catch (e) {
      state = ProductListFailState(errorMessage: e.toString());
    }
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! ProductListSuccessState) return;
    if (!currentState.hasMore || currentState.isLoadingMore) return;

    // Set loading more flag
    state = currentState.copyWith(isLoadingMore: true);

    try {
      final nextPage = currentState.currentPage + 1;
      final newProducts = await _productService.getProductList(page: nextPage);

      // Append new products to existing list
      final allProducts = [...currentState.products, ...newProducts];

      state = ProductListSuccessState(
        products: allProducts,
        currentPage: nextPage,
        hasMore: newProducts.length >= 10,
        isLoadingMore: false,
      );
    } catch (e) {
      state = currentState.copyWith(isLoadingMore: false);
    }
  }
}
