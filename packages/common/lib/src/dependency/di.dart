import 'package:common/src/const/url_const.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<void> setUpCommonDependency() async {
  GetIt getIt = GetIt.instance;
  Dio dio = Dio();
  dio.options.baseUrl = UrlConst.baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  dio.interceptors.add(PrettyDioLogger());
  getIt.registerSingleton<Dio>(
    dio,
    instanceName: 'product',
  );
}
