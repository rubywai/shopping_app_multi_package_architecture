class CartItemModel {
  final int productId;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final String? size;
  final int? variationId;

  CartItemModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    this.size,
    this.variationId,
  });

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      productId: productId,
      productName: productName,
      productImage: productImage,
      price: price,
      quantity: quantity ?? this.quantity,
      size: size,
      variationId: variationId,
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName,
        'productImage': productImage,
        'price': price,
        'quantity': quantity,
        'size': size,
        'variationId': variationId,
      };

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        productId: json['productId'] as int,
        productName: json['productName'] as String,
        productImage: json['productImage'] as String,
        price: (json['price'] as num).toDouble(),
        quantity: json['quantity'] as int,
        size: json['size'] as String?,
        variationId: json['variationId'] as int?,
      );

  String get formattedPrice => '$price price Ks';
}
