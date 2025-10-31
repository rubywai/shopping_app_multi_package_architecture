import 'package:get_it/get_it.dart';
import '../data/services/profile_service.dart';

Future<void> setUpProfileDependency() async {
  GetIt getIt = GetIt.instance;

  // Register ProfileService
  getIt.registerLazySingleton<ProfileService>(() => ProfileService());
}
