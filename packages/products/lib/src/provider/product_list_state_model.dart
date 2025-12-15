import 'package:products/src/data/model/product_list_model.dart';

sealed class ProductListSateModel {}

class ProductListLoadingState extends ProductListSateModel {}

class ProductListSuccessState extends ProductListSateModel {
  final List<ProductListModel> products;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;
  ProductListSuccessState({
    required this.products,
    required this.currentPage,
    required this.hasMore,
    required this.isLoadingMore,
  });

  ProductListSuccessState copyWith({
    List<ProductListModel>? products,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return ProductListSuccessState(
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class ProductListFailState extends ProductListSateModel {
  final String errorMessage;

  ProductListFailState({required this.errorMessage});
}
