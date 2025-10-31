import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';
import '../models/verify_otp_request.dart';
import '../models/verify_otp_response.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/reset_password_request.dart';
import '../models/reset_password_response.dart';

class AuthService {
  final Dio _dio = GetIt.instance.get<Dio>(instanceName: 'auth');

  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await _dio.post(
        '/auth.php?action=register',
        data: request.toJson(),
      );
      return RegisterResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest request) async {
    try {
      final response = await _dio.post(
        '/auth.php?action=verify',
        data: request.toJson(),
      );
      return VerifyOtpResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '/auth.php?action=login',
        data: request.toJson(),
      );
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest request) async {
    try {
      final response = await _dio.post(
        '/auth.php?action=reset',
        data: request.toJson(),
      );
      return ResetPasswordResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
