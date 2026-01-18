import 'package:cart/cart.dart';
import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:products/products.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (BuildContext context, GoRouterState state) {
        return const ProductSearchPage();
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) {
        return AppScaffoldPage(shell: shell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'product',
              builder: (BuildContext context, GoRouterState state) {
                return const ProductPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/category',
              name: 'category',
              builder: (BuildContext context, GoRouterState state) {
                return const CategoryPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cart',
              name: 'cart',
              builder: (BuildContext context, GoRouterState state) {
                return const CartPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (BuildContext context, GoRouterState state) {
                return const ProductPage();
              },
            ),
          ],
        ),
      ],
    )
  ],
);
