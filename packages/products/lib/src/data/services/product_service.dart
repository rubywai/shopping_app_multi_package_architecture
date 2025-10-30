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
        // Filter response to only include necessary fields for list view
        "_fields":
            "id,name,slug,price,regular_price,sale_price,on_sale,stock_status,images,categories,attributes",
      },
    );
    return (response.data as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }

  Future<ProductModel> getSingleProduct(int productId) async {
    final response = await _dio.get(
      "",
      queryParameters: {
        "endpoint": "products/$productId",
      },
    );
    return ProductModel.fromJson(response.data);
  }
}
