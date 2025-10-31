import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../models/customer_model.dart';

class ProfileService {
  final Dio _dio = GetIt.instance.get<Dio>(instanceName: 'product');

  Future<CustomerModel> getCustomer(String customerId) async {
    try {
      final response = await _dio.get(
        '?endpoint=customers/$customerId',
      );

      return CustomerModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCustomer(
      String customerId, Map<String, dynamic> data) async {
    try {
      await _dio.put(
        '?endpoint=customers/$customerId',
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }
}
