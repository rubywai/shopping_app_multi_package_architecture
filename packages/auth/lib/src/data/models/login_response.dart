import 'dart:convert';

class LoginResponse {
  final bool success;
  final LoginResponseData? data;
  final String? note;

  LoginResponse({
    required this.success,
    this.data,
    this.note,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] as bool,
      data: json['data'] != null
          ? LoginResponseData.fromJson(json['data'])
          : null,
      note: json['note'] as String?,
    );
  }
}

class LoginResponseData {
  final bool success;
  final LoginData? data;

  LoginResponseData({
    required this.success,
    this.data,
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      success: json['success'] as bool,
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

class LoginData {
  final String jwt;
  final int? iat;
  final int? exp;
  final String? email;
  final String? id;
  final String? site;
  final String? username;
  final String? iss;

  LoginData({
    required this.jwt,
    this.iat,
    this.exp,
    this.email,
    this.id,
    this.site,
    this.username,
    this.iss,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    final jwt = json['jwt'] as String;

    // Decode JWT to extract user info
    Map<String, dynamic>? decodedPayload;
    try {
      final parts = jwt.split('.');
      if (parts.length == 3) {
        final payload = parts[1];
        final normalized = base64Url.normalize(payload);
        final decoded = utf8.decode(base64Url.decode(normalized));
        decodedPayload = jsonDecode(decoded) as Map<String, dynamic>;
      }
    } catch (e) {
      // If decoding fails, use empty map
      decodedPayload = {};
    }

    return LoginData(
      jwt: jwt,
      iat: decodedPayload?['iat'] as int?,
      exp: decodedPayload?['exp'] as int?,
      email: decodedPayload?['email'] as String?,
      id: decodedPayload?['id']?.toString(),
      site: decodedPayload?['site'] as String?,
      username: decodedPayload?['username'] as String?,
      iss: decodedPayload?['iss'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jwt': jwt,
      'iat': iat,
      'exp': exp,
      'email': email,
      'id': id,
      'site': site,
      'username': username,
      'iss': iss,
    };
  }
}
