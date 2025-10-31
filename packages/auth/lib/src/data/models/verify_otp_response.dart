class VerifyOtpResponse {
  final bool success;
  final String message;
  final VerifyOtpData? data;
  final String? note;

  VerifyOtpResponse({
    required this.success,
    required this.message,
    this.data,
    this.note,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String,
      data: json['data'] != null ? VerifyOtpData.fromJson(json['data']) : null,
      note: json['note'] as String?,
    );
  }
}

class VerifyOtpData {
  final bool success;
  final String id;
  final String message;
  final UserInfo? user;
  final List<String>? roles;

  VerifyOtpData({
    required this.success,
    required this.id,
    required this.message,
    this.user,
    this.roles,
  });

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) {
    return VerifyOtpData(
      success: json['success'] as bool? ?? false,
      id: json['id'].toString(),
      message: json['message'] as String,
      user: json['user'] != null ? UserInfo.fromJson(json['user']) : null,
      roles: json['roles'] != null
          ? (json['roles'] as List).map((e) => e.toString()).toList()
          : null,
    );
  }
}

class UserInfo {
  final String id;
  final String userLogin;
  final String userNicename;
  final String userEmail;
  final String userUrl;
  final String userRegistered;
  final String userActivationKey;
  final String userStatus;
  final String displayName;

  UserInfo({
    required this.id,
    required this.userLogin,
    required this.userNicename,
    required this.userEmail,
    required this.userUrl,
    required this.userRegistered,
    required this.userActivationKey,
    required this.userStatus,
    required this.displayName,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['ID'].toString(),
      userLogin: json['user_login'] as String,
      userNicename: json['user_nicename'] as String,
      userEmail: json['user_email'] as String,
      userUrl: json['user_url'] as String? ?? '',
      userRegistered: json['user_registered'] as String,
      userActivationKey: json['user_activation_key'] as String? ?? '',
      userStatus: json['user_status'].toString(),
      displayName: json['display_name'] as String,
    );
  }
}
