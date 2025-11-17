import 'package:common/common.dart';
import 'package:cart/cart.dart';
import 'package:auth/auth.dart';
import 'package:profile/profile.dart';
import 'package:orders/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpCommonDependency(routes);
  await setUpCartDependency();
  await setUpAuthDependency();
  await setUpProfileDependency();
  await setUpOrderDependency();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routes,
    );
  }
}
