import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

/// Interceptor that handles unauthorized API responses (401, 403)
/// and redirects users to login page
class AuthInterceptor extends Interceptor {
  final GoRouter router;

  AuthInterceptor(this.router);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Check if the error is due to unauthorized access
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      // Redirect to login page
      router.go('/login');
    }

    // Continue with the error
    handler.next(err);
  }
}
