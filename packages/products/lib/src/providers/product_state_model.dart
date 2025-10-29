import '../data/models/product_model.dart';

sealed class ProductStateModel {}

class ProductStateLoading extends ProductStateModel {}

class ProductStateFailed extends ProductStateModel {
  final String message;
  ProductStateFailed({required this.message});
}

class ProductStateSuccess extends ProductStateModel {
  final List<ProductModel> products;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;

  ProductStateSuccess({
    required this.products,
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  ProductStateSuccess copyWith({
    List<ProductModel>? products,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return ProductStateSuccess(
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
