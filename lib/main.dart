import 'package:flutter/material.dart';
import 'package:shopping_app_multi_package_based_architecture/routes/routes.dart';

//auth
//products
//category
//cart
//profile
//orders
void main() async {
  runApp(const MyApp());
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
