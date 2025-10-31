import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../models/create_order_request.dart';
import '../models/create_order_response.dart';

class OrderService {
  final Dio _dio = GetIt.instance.get<Dio>(instanceName: 'product');

  Future<CreateOrderResponse> createOrder(CreateOrderRequest request) async {
    try {
      final response = await _dio.post(
        '?endpoint=orders',
        data: request.toJson(),
      );
      // API returns array with single order object
      if (response.data is List && (response.data as List).isNotEmpty) {
        return CreateOrderResponse.fromJson(response.data[0]);
      }
      return CreateOrderResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CreateOrderResponse>> getOrders({
    required String customerId,
  }) async {
    try {
      final response = await _dio.get(
        '?endpoint=orders',
        queryParameters: {'customer': customerId},
      );
      return (response.data as List)
          .map((e) => CreateOrderResponse.fromJson(e))
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
