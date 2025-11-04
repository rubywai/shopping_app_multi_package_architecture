import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../models/create_order_request.dart';
import '../models/create_order_response.dart';
import '../models/order_list_model.dart';

class OrderService {
  final Dio _dio = GetIt.instance.get<Dio>(instanceName: 'product');

  Future<CreateOrderResponse> createOrder(CreateOrderRequest request) async {
    try {
      final response = await _dio.post(
        '?endpoint=orders',
        data: request.toJson(),
      );

      // API can return either array or single object
      if (response.data is List) {
        if ((response.data as List).isNotEmpty) {
          return CreateOrderResponse.fromJson(response.data[0]);
        } else {
          throw Exception('Empty response from order creation');
        }
      } else {
        return CreateOrderResponse.fromJson(response.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderListModel>> getOrders({
    required String customerId,
    String? status,
  }) async {
    try {
      final queryParams = {
        'customer': customerId,
        '_fields': 'id,status,total,date_created,line_items',
      };

      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }

      final response = await _dio.get(
        '?endpoint=orders',
        queryParameters: queryParams,
      );
      return (response.data as List)
          .map((e) => OrderListModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<CreateOrderResponse> getOrderById({required int id}) async {
    try {
      final response = await _dio.get('?endpoint=orders&id=$id');
      return CreateOrderResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
