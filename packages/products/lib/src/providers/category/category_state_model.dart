import '../../data/models/category_model.dart';

sealed class CategoryStateModel {}

class CategoryStateLoading extends CategoryStateModel {}

class CategoryStateFailed extends CategoryStateModel {
  final String message;
  CategoryStateFailed({required this.message});
}

class CategoryStateSuccess extends CategoryStateModel {
  final List<CategoryModel> categories;

  CategoryStateSuccess({required this.categories});
}
