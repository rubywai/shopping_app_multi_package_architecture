import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/category_service.dart';
import 'category_state_model.dart';

typedef CategoryStateProvider
    = NotifierProvider<CategoryStateNotifier, CategoryStateModel>;

class CategoryStateNotifier extends Notifier<CategoryStateModel> {
  final CategoryService _categoryService = CategoryService();

  @override
  CategoryStateModel build() {
    return CategoryStateLoading();
  }

  Future<void> fetchCategories() async {
    state = CategoryStateLoading();
    try {
      final categories = await _categoryService.getCategories();
      state = CategoryStateSuccess(categories: categories);
    } catch (e) {
      state = CategoryStateFailed(message: e.toString());
    }
  }
}
