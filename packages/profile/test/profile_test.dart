import 'package:flutter_test/flutter_test.dart';
import 'package:profile/profile.dart';

void main() {
  test('CustomerModel should parse from JSON', () {
    final json = {
      'id': 5,
      'date_created': '2025-10-31T04:07:50',
      'date_created_gmt': '2025-10-31T04:07:50',
      'date_modified': null,
      'date_modified_gmt': null,
      'email': 'test@example.com',
      'first_name': 'Test',
      'last_name': 'User',
      'role': 'subscriber',
      'username': 'testuser',
      'billing': {
        'first_name': '',
        'last_name': '',
        'company': '',
        'address_1': '',
        'address_2': '',
        'city': '',
        'postcode': '',
        'country': '',
        'state': '',
        'email': '',
        'phone': '',
      },
      'shipping': {
        'first_name': '',
        'last_name': '',
        'company': '',
        'address_1': '',
        'address_2': '',
        'city': '',
        'postcode': '',
        'country': '',
        'state': '',
        'phone': '',
      },
      'is_paying_customer': false,
      'avatar_url': 'https://example.com/avatar.jpg',
      'meta_data': [],
    };

    final customer = CustomerModel.fromJson(json);

    expect(customer.id, 5);
    expect(customer.email, 'test@example.com');
    expect(customer.username, 'testuser');
  });
}
