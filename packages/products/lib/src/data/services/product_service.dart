import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../models/product_list_model.dart';
import '../models/product_detail_model.dart';

class ProductService {
  final Dio _dio = GetIt.I.get(instanceName: 'product');

  Future<List<ProductListModel>> getProducts({
    int page = 1,
    int perPage = 20,
    String? search,
    int? category,
  }) async {
    final queryParams = {
      "endpoint": "products",
      "page": page,
      "per_page": perPage,
      "_fields":
          "id,name,slug,price,regular_price,sale_price,on_sale,stock_status,images,categories",
    };

    if (search != null && search.trim().isNotEmpty) {
      queryParams["search"] = search;
    }

    if (category != null) {
      queryParams["category"] = category.toString();
    }

    final response = await _dio.get("", queryParameters: queryParams);
    return (response.data as List)
        .map((e) => ProductListModel.fromJson(e))
        .toList();
  }

  Future<ProductDetailModel> getSingleProduct(int productId) async {
    final response = await _dio.get(
      "",
      queryParameters: {
        "endpoint": "products/$productId",
        "_fields":
            "id,name,slug,price,regular_price,sale_price,on_sale,stock_status,description,short_description,images,categories,attributes,default_attributes,variations,average_rating,rating_count,reviews_allowed,sku,weight,dimensions,type,total_sales,tags,shipping_required,shipping_class",
      },
    );
    return ProductDetailModel.fromJson(response.data);
  }
}
