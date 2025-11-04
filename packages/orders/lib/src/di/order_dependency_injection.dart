import 'package:get_it/get_it.dart';
import '../data/services/order_service.dart';

Future<void> setUpOrderDependency() async {
  GetIt getIt = GetIt.instance;

  // Register OrderService
  getIt.registerLazySingleton<OrderService>(() => OrderService());
}
