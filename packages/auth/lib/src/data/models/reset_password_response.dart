class ResetPasswordResponse {
  final bool success;
  final String data;

  ResetPasswordResponse({
    required this.success,
    required this.data,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      success: json['success'] as bool,
      data: json['data'] as String,
    );
  }
}
