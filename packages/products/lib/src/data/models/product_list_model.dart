class ProductListModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? price;
  final String? regularPrice;
  final String? salePrice;
  final bool? onSale;
  final String? stockStatus;
  final List<ProductImage>? images;
  final List<ProductCategory>? categories;

  ProductListModel({
    this.id,
    this.name,
    this.slug,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.stockStatus,
    this.images,
    this.categories,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      price: json['price'],
      regularPrice: json['regular_price'],
      salePrice: json['sale_price'],
      onSale: json['on_sale'],
      stockStatus: json['stock_status'],
      images: json['images'] != null
          ? (json['images'] as List)
              .map((e) => ProductImage.fromJson(e))
              .toList()
          : null,
      categories: json['categories'] != null
          ? (json['categories'] as List)
              .map((e) => ProductCategory.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'price': price,
      'regular_price': regularPrice,
      'sale_price': salePrice,
      'on_sale': onSale,
      'stock_status': stockStatus,
      'images': images?.map((e) => e.toJson()).toList(),
      'categories': categories?.map((e) => e.toJson()).toList(),
    };
  }
}

class ProductImage {
  final int? id;
  final String? src;
  final String? thumbnail;

  ProductImage({
    this.id,
    this.src,
    this.thumbnail,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      src: json['src'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'src': src,
      'thumbnail': thumbnail,
    };
  }
}

class ProductCategory {
  final int? id;
  final String? name;
  final String? slug;

  ProductCategory({
    this.id,
    this.name,
    this.slug,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }
}
