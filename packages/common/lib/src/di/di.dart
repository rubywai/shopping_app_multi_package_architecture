import 'package:common/src/const/api_const.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<void> setUpDependencies() async {
  GetIt getIt = GetIt.I;
  Dio dio = Dio();
  dio.options.baseUrl = ApiConst.productBaseUrl;
  dio.options.connectTimeout = const Duration(seconds: 15);
  dio.options.receiveTimeout = const Duration(seconds: 15);
  dio.interceptors.add(
    PrettyDioLogger(requestHeader: true, responseBody: true),
  );
  getIt.registerSingleton(dio);
}
