import 'package:flutter_test/flutter_test.dart';

import 'package:cart/cart.dart';

void main() {
  test('cart item model serialization', () {
    final item = CartItemModel(
      productId: 1,
      productName: 'Test Product',
      productImage: 'test.jpg',
      price: 10.0,
      quantity: 2,
    );

    expect(item.totalPrice, 20.0);
    expect(item.productName, 'Test Product');
  });
}
