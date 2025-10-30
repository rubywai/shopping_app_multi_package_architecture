import '../models/cart_item_model.dart';

class CartService {
  final List<CartItemModel> _items = [];

  Future<void> addToCart(CartItemModel item) async {
    // Simulate small delay (e.g., DB write)
    await Future.delayed(const Duration(milliseconds: 100));

    final index = _items.indexWhere((e) =>
        e.productId == item.productId &&
        e.size == item.size &&
        e.variationId == item.variationId);

    if (index >= 0) {
      final existing = _items[index];
      _items[index] =
          existing.copyWith(quantity: existing.quantity + item.quantity);
    } else {
      _items.add(item);
    }
  }

  List<CartItemModel> get items => List.unmodifiable(_items);

  Future<void> clear() async {
    _items.clear();
  }
}
