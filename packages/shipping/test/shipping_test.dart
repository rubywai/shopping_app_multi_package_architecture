import 'package:flutter_test/flutter_test.dart';
import 'package:shipping/shipping.dart';

void main() {
  group('ShippingMethod', () {
    test('creates shipping method from JSON', () {
      final json = {
        'id': 1,
        'instance_id': 1,
        'title': 'Flat rate',
        'method_id': 'flat_rate',
        'order': 1,
        'enabled': true,
        'method_title': 'Flat rate',
        'method_description': 'Flat rate shipping',
        'settings': {
          'cost': {'value': '20'},
        },
      };

      final method = ShippingMethod.fromJson(json);

      expect(method.id, 1);
      expect(method.title, 'Flat rate');
      expect(method.cost, '20');
      expect(method.displayCost, '20 Ks');
      expect(method.totalCost, '20');
    });

    test('handles free shipping (no cost)', () {
      final json = {
        'id': 2,
        'instance_id': 2,
        'title': 'Free shipping',
        'method_id': 'free_shipping',
        'order': 2,
        'enabled': true,
        'method_title': 'Free shipping',
        'method_description': '',
        'settings': {},
      };

      final method = ShippingMethod.fromJson(json);

      expect(method.cost, isNull);
      expect(method.displayCost, 'Free');
      expect(method.totalCost, '0');
    });
  });
}
