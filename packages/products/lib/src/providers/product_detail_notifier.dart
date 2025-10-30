import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/product_service.dart';
import 'product_detail_state_model.dart';

class ProductDetailNotifier
    extends AutoDisposeFamilyNotifier<ProductDetailStateModel, int> {
  final ProductService _productService = ProductService();

  @override
  ProductDetailStateModel build(int productId) {
    fetchProductDetail(productId);
    return ProductDetailLoading();
  }

  Future<void> fetchProductDetail(int productId) async {
    state = ProductDetailLoading();
    try {
      final product = await _productService.getSingleProduct(productId);
      state = ProductDetailSuccess(product: product);
    } catch (e) {
      state = ProductDetailFailed(message: e.toString());
    }
  }
}

// Global provider with family parameter for product ID
final productDetailProvider = AutoDisposeNotifierProviderFamily<
    ProductDetailNotifier, ProductDetailStateModel, int>(
  ProductDetailNotifier.new,
);
