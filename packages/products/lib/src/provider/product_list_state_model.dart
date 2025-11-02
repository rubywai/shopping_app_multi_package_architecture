import 'package:products/src/data/model/product_list_model.dart';

sealed class ProductListSateModel {}

class ProductListLoadingState extends ProductListSateModel {}

class ProductListSuccessState extends ProductListSateModel {
  final List<ProductListModel> products;
  ProductListSuccessState({required this.products});
}

class ProductListFailState extends ProductListSateModel {
  final String errorMessage;

  ProductListFailState({required this.errorMessage});
}
