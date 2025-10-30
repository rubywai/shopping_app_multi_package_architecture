import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/product_service.dart';
import 'product_detail_state_model.dart';

typedef ProductDetailProvider
    = NotifierProvider<ProductDetailNotifier, ProductDetailStateModel>;

class ProductDetailNotifier extends Notifier<ProductDetailStateModel> {
  final ProductService _productService = ProductService();

  @override
  ProductDetailStateModel build() {
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
