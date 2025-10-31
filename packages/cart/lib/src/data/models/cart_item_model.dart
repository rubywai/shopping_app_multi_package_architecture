class CartItemModel {
  final int? id;
  final int productId;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final String? size;
  final String? color;
  final int? variationId;

  CartItemModel({
    this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    this.size,
    this.color,
    this.variationId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'product_image': productImage,
      'price': price,
      'quantity': quantity,
      'size': size,
      'color': color,
      'variation_id': variationId,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as int?,
      productId: map['product_id'] as int,
      productName: map['product_name'] as String,
      productImage: map['product_image'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      size: map['size'] as String?,
      color: map['color'] as String?,
      variationId: map['variation_id'] as int?,
    );
  }

  CartItemModel copyWith({
    int? id,
    int? productId,
    String? productName,
    String? productImage,
    double? price,
    int? quantity,
    String? size,
    String? color,
    int? variationId,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
      variationId: variationId ?? this.variationId,
    );
  }

  double get totalPrice => price * quantity;
}
