import '../../data/model/category_model.dart';

sealed class CategoryStateModel {}
class CategoryStateLoading extends CategoryStateModel{}
class CategoryStateSuccess extends CategoryStateModel{
  final List<CategoryModel> categories;
  CategoryStateSuccess({required this.categories});
}
class CategoryStateFail extends CategoryStateModel{
  final String errorMessage;
  CategoryStateFail({required this.errorMessage});
}