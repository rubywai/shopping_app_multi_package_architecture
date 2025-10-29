import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../models/product_model.dart';

class ProductService {
  final Dio _dio = GetIt.I.get(instanceName: 'product');

  Future<List<ProductModel>> getProducts({
    int page = 1,
    int perPage = 20,
  }) async {
    final response = await _dio.get(
      "",
      queryParameters: {
        "endpoint": "products",
        "page": page,
        "per_page": perPage,
      },
    );
    return (response.data as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
