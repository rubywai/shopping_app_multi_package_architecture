# Cart Package

A Flutter package for managing shopping cart functionality with local database persistence using SQLite.

## Features

- Add products to cart
- Update product quantities
- Remove products from cart
- Clear entire cart
- Persist cart data locally using SQLite
- Support for product variations (size, etc.)
- Cart total and item count calculations

## Structure

```
cart/
├── lib/
│   ├── src/
│   │   ├── data/
│   │   │   ├── database/
│   │   │   │   └── cart_database.dart      # SQLite database implementation
│   │   │   ├── models/
│   │   │   │   └── cart_item_model.dart    # Cart item data model
│   │   │   └── services/
│   │   │       └── cart_service.dart       # Cart business logic
│   │   ├── di/
│   │   │   └── cart_dependency_injection.dart  # Dependency injection setup
│   │   ├── providers/
│   │   │   └── cart_state_notifier.dart    # State management with Riverpod
│   │   └── ui/
│   │       ├── pages/
│   │       │   └── cart_page.dart          # Cart page UI
│   │       └── widgets/
│   │           └── add_to_cart_button.dart # Reusable add to cart buttons
│   └── cart.dart                           # Package exports
└── pubspec.yaml
```

## Usage

### 1. Initialize Cart Dependency

In your `main.dart`:

```dart
import 'package:cart/cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpCartDependency();
  runApp(MyApp());
}
```

### 2. Add to Cart

Use the `AddToCartButton` or `AddToCartIconButton` widgets:

```dart
import 'package:cart/cart.dart';

AddToCartButton(
  productId: product.id,
  productName: product.name,
  productImage: product.image,
  price: product.price,
  size: selectedSize,
  variationId: selectedVariationId,
)
```

### 3. Cart Operations

Direct service usage:

```dart
final cartService = GetIt.instance<CartService>();

// Add item to cart
await cartService.addToCart(cartItem);

// Get all cart items
final items = await cartService.getCartItems();

// Update quantity
await cartService.updateCartItemQuantity(itemId, newQuantity);

// Increment quantity
await cartService.incrementQuantity(itemId);

// Decrement quantity
await cartService.decrementQuantity(itemId);

// Remove item
await cartService.removeFromCart(itemId);

// Clear cart
await cartService.clearCart();

// Get cart total
final total = await cartService.getCartTotal();

// Get item count
final count = await cartService.getCartItemCount();
```

## Dependencies

- `sqflite` - Local database
- `path` - File path operations
- `flutter_riverpod` - State management
- `get_it` - Dependency injection

