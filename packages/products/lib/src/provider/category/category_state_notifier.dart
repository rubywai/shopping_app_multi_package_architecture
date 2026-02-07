import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products/src/data/model/category_model.dart';

import '../../data/service/product_service.dart';
import 'category_state_model.dart';

typedef CategoryStateProvider = NotifierProvider<CategoryStateNotifier, CategoryStateModel>;

class CategoryStateNotifier extends Notifier<CategoryStateModel>{
  final ProductService _productService = ProductService();
  @override
  CategoryStateModel build() {
    return CategoryStateLoading();
  }
  void getCategoryList() async{
    try{
      state = CategoryStateLoading();
      List<CategoryModel> categories = await _productService.getCategoryList();
      state = CategoryStateSuccess(categories: categories);
    }
    catch(e){
      state = CategoryStateFail(errorMessage: e.toString());
    }
  }
}