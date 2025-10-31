import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../data/models/register_request.dart';
import '../data/models/verify_otp_request.dart';
import '../data/models/login_request.dart';
import '../data/models/reset_password_request.dart';
import '../data/models/login_response.dart';
import '../data/services/auth_service.dart';
import '../data/services/auth_storage_service.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final LoginData? userData;
  final String? error;
  final String? successMessage;

  AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.userData,
    this.error,
    this.successMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    LoginData? userData,
    String? error,
    String? successMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userData: userData ?? this.userData,
      error: error,
      successMessage: successMessage,
    );
  }
}

class AuthStateNotifier extends Notifier<AuthState> {
  late final AuthService _authService;
  late final AuthStorageService _storageService;

  @override
  AuthState build() {
    _authService = GetIt.instance.get<AuthService>();
    _storageService = GetIt.instance.get<AuthStorageService>();

    // Check if user is already logged in
    // Use Future.microtask to ensure state update completes before other widgets read it
    Future.microtask(() => _checkAuthStatus());

    return AuthState();
  }

  Future<void> _checkAuthStatus() async {
    final isLoggedIn = await _storageService.isLoggedIn();

    if (isLoggedIn) {
      final userData = await _storageService.getUserData();
      state = state.copyWith(
        isAuthenticated: true,
        userData: userData,
      );
    }
  }

  Future<bool> register(RegisterRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _authService.register(request);
      state = state.copyWith(
        isLoading: false,
        successMessage: response.message,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<bool> verifyOtp(VerifyOtpRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _authService.verifyOtp(request);
      state = state.copyWith(
        isLoading: false,
        successMessage: response.message,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<bool> login(LoginRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _authService.login(request);

      if (response.success &&
          response.data?.success == true &&
          response.data?.data != null) {
        await _storageService.saveToken(response.data!.data!.jwt);
        await _storageService.saveUserData(response.data!.data!);

        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          userData: response.data!.data,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Login failed',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<bool> resetPassword(ResetPasswordRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _authService.resetPassword(request);
      state = state.copyWith(
        isLoading: false,
        successMessage: response.data,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<void> logout() async {
    await _storageService.clearAuth();
    state = AuthState();
  }

  void clearMessages() {
    state = state.copyWith(error: null, successMessage: null);
  }
}

final authStateNotifierProvider =
    NotifierProvider<AuthStateNotifier, AuthState>(
  () => AuthStateNotifier(),
);
