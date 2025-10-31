import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../data/services/auth_service.dart';
import '../data/services/auth_storage_service.dart';

Future<void> setUpAuthDependency() async {
  GetIt getIt = GetIt.instance;

  // Register auth Dio instance
  Dio authDio = Dio();
  authDio.options.baseUrl = 'https://shopapi.rubylearner.com';
  authDio.options.connectTimeout = const Duration(seconds: 10);
  authDio.options.receiveTimeout = const Duration(seconds: 10);
  authDio.options.headers['Content-Type'] = 'application/json';
  authDio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
  ));

  getIt.registerSingleton<Dio>(authDio, instanceName: 'auth');

  // Register services
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<AuthStorageService>(() => AuthStorageService());
}
