class ProductDetailModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? price;
  final String? regularPrice;
  final String? salePrice;
  final bool? onSale;
  final String? stockStatus;
  final String? description;
  final String? shortDescription;
  final List<ProductDetailImage>? images;
  final List<ProductDetailCategory>? categories;
  final List<ProductAttribute>? attributes;
  final List<DefaultAttribute>? defaultAttributes;
  final List<num>? variations;
  final String? averageRating;
  final int? ratingCount;
  final bool? reviewsAllowed;
  final String? sku;
  final String? weight;
  final ProductDimensions? dimensions;
  final String? type;
  final int? totalSales;
  final List<ProductTag>? tags;
  final bool? shippingRequired;
  final String? shippingClass;
  final int? stockQuantity;
  final bool? manageStock;

  ProductDetailModel({
    this.id,
    this.name,
    this.slug,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.stockStatus,
    this.description,
    this.shortDescription,
    this.images,
    this.categories,
    this.attributes,
    this.defaultAttributes,
    this.variations,
    this.averageRating,
    this.ratingCount,
    this.reviewsAllowed,
    this.sku,
    this.weight,
    this.dimensions,
    this.type,
    this.totalSales,
    this.tags,
    this.shippingRequired,
    this.shippingClass,
    this.stockQuantity,
    this.manageStock,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      price: json['price'],
      regularPrice: json['regular_price'],
      salePrice: json['sale_price'],
      onSale: json['on_sale'],
      stockStatus: json['stock_status'],
      description: json['description'],
      shortDescription: json['short_description'],
      images: json['images'] != null
          ? (json['images'] as List)
              .map((e) => ProductDetailImage.fromJson(e))
              .toList()
          : null,
      categories: json['categories'] != null
          ? (json['categories'] as List)
              .map((e) => ProductDetailCategory.fromJson(e))
              .toList()
          : null,
      attributes: json['attributes'] != null
          ? (json['attributes'] as List)
              .map((e) => ProductAttribute.fromJson(e))
              .toList()
          : null,
      defaultAttributes: json['default_attributes'] != null
          ? (json['default_attributes'] as List)
              .map((e) => DefaultAttribute.fromJson(e))
              .toList()
          : null,
      variations: json['variations'] != null
          ? (json['variations'] as List).cast<num>()
          : null,
      averageRating: json['average_rating'],
      ratingCount: json['rating_count'],
      reviewsAllowed: json['reviews_allowed'],
      sku: json['sku'],
      weight: json['weight'],
      dimensions: json['dimensions'] != null
          ? ProductDimensions.fromJson(json['dimensions'])
          : null,
      type: json['type'],
      totalSales: json['total_sales'],
      tags: json['tags'] != null
          ? (json['tags'] as List).map((e) => ProductTag.fromJson(e)).toList()
          : null,
      shippingRequired: json['shipping_required'],
      shippingClass: json['shipping_class'],
      stockQuantity: json['stock_quantity'],
      manageStock: json['manage_stock'],
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
      'description': description,
      'short_description': shortDescription,
      'images': images?.map((e) => e.toJson()).toList(),
      'categories': categories?.map((e) => e.toJson()).toList(),
      'attributes': attributes?.map((e) => e.toJson()).toList(),
      'default_attributes': defaultAttributes?.map((e) => e.toJson()).toList(),
      'variations': variations,
      'average_rating': averageRating,
      'rating_count': ratingCount,
      'reviews_allowed': reviewsAllowed,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions?.toJson(),
      'type': type,
      'total_sales': totalSales,
      'tags': tags?.map((e) => e.toJson()).toList(),
      'shipping_required': shippingRequired,
      'shipping_class': shippingClass,
      'stock_quantity': stockQuantity,
      'manage_stock': manageStock,
    };
  }
}

class ProductDetailImage {
  final int? id;
  final String? src;
  final String? thumbnail;
  final String? name;
  final String? alt;

  ProductDetailImage({
    this.id,
    this.src,
    this.thumbnail,
    this.name,
    this.alt,
  });

  factory ProductDetailImage.fromJson(Map<String, dynamic> json) {
    return ProductDetailImage(
      id: json['id'],
      src: json['src'],
      thumbnail: json['thumbnail'],
      name: json['name'],
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'src': src,
      'thumbnail': thumbnail,
      'name': name,
      'alt': alt,
    };
  }
}

class ProductDetailCategory {
  final int? id;
  final String? name;
  final String? slug;

  ProductDetailCategory({
    this.id,
    this.name,
    this.slug,
  });

  factory ProductDetailCategory.fromJson(Map<String, dynamic> json) {
    return ProductDetailCategory(
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

class ProductAttribute {
  final int? id;
  final String? name;
  final String? slug;
  final int? position;
  final bool? visible;
  final bool? variation;
  final List<String>? options;

  ProductAttribute({
    this.id,
    this.name,
    this.slug,
    this.position,
    this.visible,
    this.variation,
    this.options,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      position: json['position'],
      visible: json['visible'],
      variation: json['variation'],
      options: json['options'] != null
          ? (json['options'] as List).cast<String>()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'position': position,
      'visible': visible,
      'variation': variation,
      'options': options,
    };
  }
}

class DefaultAttribute {
  final int? id;
  final String? name;
  final String? option;

  DefaultAttribute({
    this.id,
    this.name,
    this.option,
  });

  factory DefaultAttribute.fromJson(Map<String, dynamic> json) {
    return DefaultAttribute(
      id: json['id'],
      name: json['name'],
      option: json['option'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'option': option,
    };
  }
}

class ProductDimensions {
  final String? length;
  final String? width;
  final String? height;

  ProductDimensions({
    this.length,
    this.width,
    this.height,
  });

  factory ProductDimensions.fromJson(Map<String, dynamic> json) {
    return ProductDimensions(
      length: json['length'],
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'length': length,
      'width': width,
      'height': height,
    };
  }
}

class ProductTag {
  final int? id;
  final String? name;
  final String? slug;

  ProductTag({
    this.id,
    this.name,
    this.slug,
  });

  factory ProductTag.fromJson(Map<String, dynamic> json) {
    return ProductTag(
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
