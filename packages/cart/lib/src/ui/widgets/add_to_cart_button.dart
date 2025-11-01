import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/services/cart_service.dart';

class AddToCartButton extends ConsumerWidget {
  final int productId;
  final String productName;
  final String productImage;
  final double price;
  final String? size;
  final int? variationId;
  final VoidCallback? onSuccess;

  const AddToCartButton({
    super.key,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    this.size,
    this.variationId,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () => _addToCart(context),
      icon: const Icon(Icons.add_shopping_cart),
      label: const Text('Add to Cart'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }

  Future<void> _addToCart(BuildContext context) async {
    try {
      final cartService = GetIt.instance<CartService>();

      final cartItem = CartItemModel(
        productId: productId,
        productName: productName,
        productImage: productImage,
        price: price,
        quantity: 1,
        size: size,
        variationId: variationId,
      );

      await cartService.addToCart(cartItem);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Added to cart successfully!'),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'VIEW CART',
              textColor: Colors.white,
              onPressed: () {
                // TODO: Navigate to cart page
              },
            ),
          ),
        );
      }

      onSuccess?.call();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add to cart: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class AddToCartIconButton extends ConsumerWidget {
  final int productId;
  final String productName;
  final String productImage;
  final double price;
  final String? size;
  final int? variationId;
  final VoidCallback? onSuccess;

  const AddToCartIconButton({
    super.key,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    this.size,
    this.variationId,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => _addToCart(context),
      icon: const Icon(Icons.add_shopping_cart),
      tooltip: 'Add to Cart',
    );
  }

  Future<void> _addToCart(BuildContext context) async {
    try {
      final cartService = GetIt.instance<CartService>();

      final cartItem = CartItemModel(
        productId: productId,
        productName: productName,
        productImage: productImage,
        price: price,
        quantity: 1,
        size: size,
        variationId: variationId,
      );

      await cartService.addToCart(cartItem);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added to cart successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }

      onSuccess?.call();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add to cart: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

extension PriceFormatting on CartItemModel {
  String get formattedPrice => '$price price Ks';
}
