import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../models/category_model.dart';

class CategoryService {
  final Dio _dio = GetIt.I.get(instanceName: 'product');

  Future<List<CategoryModel>> getCategories({
    int page = 1,
    int perPage = 100,
    int parent = 0,
  }) async {
    final response = await _dio.get(
      "",
      queryParameters: {
        "endpoint": "products/categories",
        "page": page,
        "per_page": perPage,
        "parent": parent,
        "hide_empty": true,
        "_fields":
            "id,name,slug,parent,description,display,image,menu_order,count",
      },
    );
    return (response.data as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }
}
