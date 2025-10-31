import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../models/shipping_method.dart';

class ShippingService {
  final Dio _dio = GetIt.instance.get<Dio>(instanceName: 'shipping');

  Future<List<ShippingMethod>> getShippingMethods(int zoneId) async {
    try {
      final response = await _dio.get(
        '?endpoint=shipping/zones/$zoneId/methods',
      );

      if (response.data is List) {
        return (response.data as List)
            .map(
              (json) => ShippingMethod.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
