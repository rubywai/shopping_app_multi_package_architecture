import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/cart_item_model.dart';
import '../data/services/cart_service.dart';
import 'package:get_it/get_it.dart';

class CartState {
  final List<CartItemModel> items;
  final bool isLoading;
  final String? error;

  CartState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  double get totalPrice =>
      items.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
  int get itemCount => items.length;
  int get totalQuantity =>
      items.fold<int>(0, (sum, item) => sum + item.quantity);

  CartState copyWith({
    List<CartItemModel>? items,
    bool? isLoading,
    String? error,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CartStateNotifier extends Notifier<CartState> {
  late final CartService _cartService;

  @override
  CartState build() {
    print('🛒 CartStateNotifier: Initializing...');
    _cartService = GetIt.instance.get<CartService>();
    print('🛒 CartStateNotifier: CartService obtained');

    // Schedule loadCartItems to run after build completes
    Future.microtask(() => loadCartItems());
    print('🛒 CartStateNotifier: loadCartItems scheduled');

    return CartState();
  }

  Future<void> loadCartItems() async {
    print('🛒 loadCartItems: Starting to load cart items...');
    state = state.copyWith(isLoading: true);
    try {
      final items = await _cartService.getCartItems();
      print('🛒 loadCartItems: Loaded ${items.length} items from database');
      for (var item in items) {
        print(
            '  - ${item.productName} (qty: ${item.quantity}, price: \$${item.price})');
      }
      state = state.copyWith(items: items, isLoading: false);
      print('🛒 loadCartItems: State updated with ${items.length} items');
    } catch (e) {
      print('🛒 loadCartItems: ERROR - $e');
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> addToCart(CartItemModel item) async {
    try {
      await _cartService.addToCart(item);
      await loadCartItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> incrementQuantity(int id) async {
    try {
      await _cartService.incrementQuantity(id);
      await loadCartItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> decrementQuantity(int id) async {
    try {
      await _cartService.decrementQuantity(id);
      await loadCartItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> removeFromCart(int id) async {
    try {
      await _cartService.removeFromCart(id);
      await loadCartItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> clearCart() async {
    try {
      await _cartService.clearCart();
      await loadCartItems();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateQuantity(int id, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(id);
    } else {
      try {
        await _cartService.updateCartItemQuantity(id, quantity);
        await loadCartItems();
      } catch (e) {
        state = state.copyWith(error: e.toString());
      }
    }
  }
}

// Provider
final cartStateNotifierProvider =
    NotifierProvider<CartStateNotifier, CartState>(
  () => CartStateNotifier(),
);
