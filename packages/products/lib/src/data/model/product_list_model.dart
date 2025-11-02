class ProductListModel {
  ProductListModel({
    this.id,
    this.name,
    this.slug,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.manageStock,
    this.stockQuantity,
    this.backorders,
    this.backordersAllowed,
    this.images,
    this.categories,
    this.stockStatus,
  });

  ProductListModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    onSale = json['on_sale'];
    manageStock = json['manage_stock'];
    stockQuantity = json['stock_quantity'];
    backorders = json['backorders'];
    backordersAllowed = json['backorders_allowed'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    stockStatus = json['stock_status'];
  }
  num? id;
  String? name;
  String? slug;
  String? price;
  String? regularPrice;
  String? salePrice;
  bool? onSale;
  bool? manageStock;
  num? stockQuantity;
  String? backorders;
  bool? backordersAllowed;
  List<Images>? images;
  List<Categories>? categories;
  String? stockStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['price'] = price;
    map['regular_price'] = regularPrice;
    map['sale_price'] = salePrice;
    map['on_sale'] = onSale;
    map['manage_stock'] = manageStock;
    map['stock_quantity'] = stockQuantity;
    map['backorders'] = backorders;
    map['backorders_allowed'] = backordersAllowed;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    map['stock_status'] = stockStatus;
    return map;
  }
}

class Categories {
  Categories({this.id, this.name, this.slug});

  Categories.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }
  num? id;
  String? name;
  String? slug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    return map;
  }
}

class Images {
  Images({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
    this.srcset,
    this.sizes,
    this.thumbnail,
  });

  Images.fromJson(dynamic json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
    srcset = json['srcset'];
    sizes = json['sizes'];
    thumbnail = json['thumbnail'];
  }
  num? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;
  String? srcset;
  String? sizes;
  String? thumbnail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date_created'] = dateCreated;
    map['date_created_gmt'] = dateCreatedGmt;
    map['date_modified'] = dateModified;
    map['date_modified_gmt'] = dateModifiedGmt;
    map['src'] = src;
    map['name'] = name;
    map['alt'] = alt;
    map['srcset'] = srcset;
    map['sizes'] = sizes;
    map['thumbnail'] = thumbnail;
    return map;
  }
}
