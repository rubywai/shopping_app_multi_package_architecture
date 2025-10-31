class RegisterRequest {
  final String email;
  final String password;
  final String displayName;
  final String userLogin;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.displayName,
    required this.userLogin,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'display_name': displayName,
      'user_login': userLogin,
    };
  }
}
