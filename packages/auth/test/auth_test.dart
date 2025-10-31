import 'package:flutter_test/flutter_test.dart';
import 'package:auth/auth.dart';

void main() {
  test('LoginRequest should convert to JSON', () {
    final request = LoginRequest(
      email: 'test@example.com',
      password: 'password123',
    );

    final json = request.toJson();

    expect(json['email'], 'test@example.com');
    expect(json['password'], 'password123');
  });
}
