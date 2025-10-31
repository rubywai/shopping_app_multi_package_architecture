class RegisterResponse {
  final bool success;
  final String message;
  final RegisterData? data;
  final String? note;

  RegisterResponse({
    required this.success,
    required this.message,
    this.data,
    this.note,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null ? RegisterData.fromJson(json['data']) : null,
      note: json['note'] as String?,
    );
  }
}

class RegisterData {
  final bool success;
  final String id;
  final String message;
  final RegisterUser? user;
  final List<String>? roles;

  RegisterData({
    required this.success,
    required this.id,
    required this.message,
    this.user,
    this.roles,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      success: json['success'] as bool,
      id: json['id'].toString(),
      message: json['message'] as String,
      user: json['user'] != null ? RegisterUser.fromJson(json['user']) : null,
      roles: json['roles'] != null
          ? List<String>.from(json['roles'] as List)
          : null,
    );
  }
}

class RegisterUser {
  final String id;
  final String userLogin;
  final String userNicename;
  final String userEmail;
  final String userUrl;
  final String userRegistered;
  final String userActivationKey;
  final String userStatus;
  final String displayName;

  RegisterUser({
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

  factory RegisterUser.fromJson(Map<String, dynamic> json) {
    return RegisterUser(
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
