import '../database/cart_database.dart';
import '../models/cart_item_model.dart';

class CartService {
  final CartDatabase _database = CartDatabase.instance;

  Future<int> addToCart(CartItemModel item) async {
    return await _database.insertCartItem(item);
  }

  Future<List<CartItemModel>> getCartItems() async {
    final items = await _database.getAllCartItems();
    return items;
  }

  Future<int> updateCartItemQuantity(int id, int quantity) async {
    final items = await _database.getAllCartItems();
    final item = items.firstWhere((item) => item.id == id);
    final updatedItem = item.copyWith(quantity: quantity);
    return await _database.updateCartItem(updatedItem);
  }

  Future<int> incrementQuantity(int id) async {
    final items = await _database.getAllCartItems();
    final item = items.firstWhere((item) => item.id == id);
    final updatedItem = item.copyWith(quantity: item.quantity + 1);
    return await _database.updateCartItem(updatedItem);
  }

  Future<int> decrementQuantity(int id) async {
    final items = await _database.getAllCartItems();
    final item = items.firstWhere((item) => item.id == id);

    if (item.quantity <= 1) {
      return await _database.deleteCartItem(id);
    } else {
      final updatedItem = item.copyWith(quantity: item.quantity - 1);
      return await _database.updateCartItem(updatedItem);
    }
  }

  Future<int> removeFromCart(int id) async {
    return await _database.deleteCartItem(id);
  }

  Future<int> clearCart() async {
    return await _database.clearCart();
  }

  Future<int> getCartItemCount() async {
    return await _database.getCartItemCount();
  }

  Future<double> getCartTotal() async {
    return await _database.getCartTotal();
  }
}
