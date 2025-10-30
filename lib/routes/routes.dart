import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products/products.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (
        context,
        state,
        navigationShell,
      ) {
        return AppScaffold(shell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'products',
              builder: (context, state) {
                return const ProductListPage();
              },
              routes: [
                GoRoute(
                  path: 'product/:id',
                  name: 'product-detail',
                  builder: (context, state) {
                    final productId = int.parse(state.pathParameters['id']!);
                    return ProductDetailPage(productId: productId);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/category',
              name: 'category',
              builder: (context, state) {
                return const Center(
                  child: Text("Category"),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cart',
              name: 'cart',
              builder: (context, state) {
                return const Center(
                  child: Text("Cart"),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/person',
              name: 'person',
              builder: (context, state) {
                return const Center(
                  child: Text("Person"),
                );
              },
            ),
          ],
        ),
      ],
    )
  ],
);
