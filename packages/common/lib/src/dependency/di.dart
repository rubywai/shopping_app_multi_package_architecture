import 'package:common/src/const/url_const.dart';
import 'package:common/src/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<void> setUpCommonDependency(GoRouter router) async {
  GetIt getIt = GetIt.instance;

  // Create auth interceptor
  final authInterceptor = AuthInterceptor(router);

  // Product Dio
  Dio productDio = Dio();
  productDio.options.baseUrl = UrlConst.baseUrl;
  productDio.options.connectTimeout = const Duration(seconds: 30);
  productDio.options.receiveTimeout = const Duration(seconds: 30);
  productDio.interceptors.addAll([
    authInterceptor,
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    ),
  ]);
  getIt.registerSingleton<Dio>(
    productDio,
    instanceName: 'product',
  );

  // Shipping Dio (can reuse same config or customize)
  Dio shippingDio = Dio();
  shippingDio.options.baseUrl = UrlConst.baseUrl;
  shippingDio.options.connectTimeout = const Duration(seconds: 30);
  shippingDio.options.receiveTimeout = const Duration(seconds: 30);
  shippingDio.interceptors.addAll([
    authInterceptor,
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    ),
  ]);
  getIt.registerSingleton<Dio>(
    shippingDio,
    instanceName: 'shipping',
  );

  // Note: Auth Dio is registered in auth package's setUpAuthDependency()
}
