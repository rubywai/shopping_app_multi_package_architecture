import '../../../products.dart';

sealed class ProductDetailStateModel {}

class ProductDetailLoading extends ProductDetailStateModel {}

class ProductDetailFailed extends ProductDetailStateModel {
  final String message;
  ProductDetailFailed({required this.message});
}

class ProductDetailSuccess extends ProductDetailStateModel {
  final ProductDetailModel product;
  ProductDetailSuccess({required this.product});
}
