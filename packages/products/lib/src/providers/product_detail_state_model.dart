import '../data/models/product_model.dart';

sealed class ProductDetailStateModel {}

class ProductDetailLoading extends ProductDetailStateModel {}

class ProductDetailFailed extends ProductDetailStateModel {
  final String message;
  ProductDetailFailed({required this.message});
}

class ProductDetailSuccess extends ProductDetailStateModel {
  final ProductModel product;
  ProductDetailSuccess({required this.product});
}
