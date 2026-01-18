import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:products/src/data/model/product_list_model.dart';

class ProductService {
  final Dio _dio = GetIt.I.get();
  Future<List<ProductListModel>> getProductList({
    int page = 1,
    int perPage = 10,
    String? search,
  }) async {
    final Map<String,dynamic> queryParams = {
      'endpoint': 'products',
      'page': page,
      'per_page': perPage,
      '_fields':
      'id,name,slug,price,regular_price,sale_price,on_sale,stock_status,manage_stock,stock_quantity,backorders,backorders_allowed,images,categories',
    };
    if(search != null && search.trim().isNotEmpty){
      queryParams['search'] = search;
    }
    final res = await _dio.get(
      "",
      queryParameters: queryParams,
    );

    return (res.data as List).map((e) {
      return ProductListModel.fromJson(e);
    }).toList();
  }
}
