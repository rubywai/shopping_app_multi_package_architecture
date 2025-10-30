import 'package:get_it/get_it.dart';
import '../data/services/cart_service.dart';

Future<void> setUpCartDependency() async {
  GetIt getIt = GetIt.instance;

  getIt.registerLazySingleton(() => CartService());
}
