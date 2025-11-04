import 'package:common/common.dart';
import 'package:go_router/go_router.dart';
import 'package:products/products.dart';
import 'package:cart/cart.dart';
import 'package:auth/auth.dart';
import 'package:profile/profile.dart';
import 'package:orders/orders.dart';
import 'package:get_it/get_it.dart';

final routes = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) async {
    final authStorage = GetIt.instance.get<AuthStorageService>();
    final isAuthenticated = await authStorage.isLoggedIn();

    final isAuthRoute = state.matchedLocation == '/login' ||
        state.matchedLocation == '/register' ||
        state.matchedLocation == '/verify-otp' ||
        state.matchedLocation == '/forgot-password';

    // If user is authenticated and trying to access auth pages, redirect to products
    if (isAuthenticated && isAuthRoute) {
      return '/products';
    }

    // If user is not authenticated and trying to access protected pages, redirect to login
    if (!isAuthenticated && !isAuthRoute) {
      return '/login';
    }

    return null; // No redirect needed
  },
  routes: [
    // Auth routes (outside bottom nav)
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/verify-otp',
      name: 'verify-otp',
      builder: (context, state) {
        final email = state.extra as String;
        return VerifyOtpPage(email: email);
      },
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/checkout',
      name: 'checkout',
      builder: (context, state) => const CheckoutPage(),
    ),
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
              path: '/products',
              name: 'products',
              builder: (context, state) {
                return const ProductListPage();
              },
            ),
            GoRoute(
              path: '/product/:id',
              name: 'product-detail',
              builder: (context, state) {
                final productId = int.parse(state.pathParameters['id']!);
                return ProductDetailPage(
                  productId: productId,
                );
              },
            ),
            GoRoute(
              path: '/search',
              name: 'search',
              builder: (context, state) {
                return const ProductSearchPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/category',
              name: 'category',
              builder: (context, state) {
                return const CategoryPage();
              },
              routes: [
                GoRoute(
                  path: ':id',
                  name: 'category-products',
                  builder: (context, state) {
                    final categoryId = int.parse(state.pathParameters['id']!);
                    final categoryName =
                        state.uri.queryParameters['name'] ?? 'Category';
                    return CategoryProductsPage(
                      categoryId: categoryId,
                      categoryName: categoryName,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cart',
              name: 'cart',
              builder: (context, state) {
                return const CartPage();
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
                return const ProfilePage();
              },
            ),
          ],
        ),
      ],
    ),
    // Edit billing route (outside bottom nav)
    GoRoute(
      path: '/profile/edit-billing',
      name: 'edit-billing',
      builder: (context, state) {
        final customer = state.extra as CustomerModel;
        return EditBillingPage(customer: customer);
      },
    ),
    // Edit customer info route (outside bottom nav)
    GoRoute(
      path: '/profile/edit-info',
      name: 'edit-info',
      builder: (context, state) {
        final customer = state.extra as CustomerModel;
        return EditCustomerInfoPage(customer: customer);
      },
    ),
    // Orders route (outside bottom nav)
    GoRoute(
      path: '/orders',
      name: 'orders',
      builder: (context, state) => const OrderListPage(),
    ),
  ],
);
