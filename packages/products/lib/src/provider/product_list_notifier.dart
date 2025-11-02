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
      state = ProductListSuccessState(products: products);
    } catch (e) {
      state = ProductListFailState(errorMessage: e.toString());
    }
  }
}
