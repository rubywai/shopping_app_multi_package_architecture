class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.type,
    this.status,
    this.featured,
    this.catalogVisibility,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloads,
    this.downloadLimit,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.lowStockAmount,
    this.soldIndividually,
    this.weight,
    this.dimensions,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.upsellIds,
    this.crossSellIds,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.brands,
    this.tags,
    this.images,
    this.attributes,
    this.defaultAttributes,
    this.variations,
    this.groupedProducts,
    this.menuOrder,
    this.priceHtml,
    this.relatedIds,
    this.metaData,
    this.stockStatus,
    this.hasOptions,
    this.postPassword,
    this.globalUniqueId,
    this.jetpackSharingEnabled,
    this.links,
  });

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    permalink = json['permalink'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    type = json['type'];
    status = json['status'];
    featured = json['featured'];
    catalogVisibility = json['catalog_visibility'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    dateOnSaleFrom = json['date_on_sale_from'];
    dateOnSaleFromGmt = json['date_on_sale_from_gmt'];
    dateOnSaleTo = json['date_on_sale_to'];
    dateOnSaleToGmt = json['date_on_sale_to_gmt'];
    onSale = json['on_sale'];
    purchasable = json['purchasable'];
    totalSales = json['total_sales'];
    virtual = json['virtual'];
    downloadable = json['downloadable'];
    // if (json['downloads'] != null) {
    //   downloads = [];
    //   json['downloads'].forEach((v) {
    //     downloads?.add(Dynamic.fromJson(v));
    //   });
    // }
    downloadLimit = json['download_limit'];
    downloadExpiry = json['download_expiry'];
    externalUrl = json['external_url'];
    buttonText = json['button_text'];
    taxStatus = json['tax_status'];
    taxClass = json['tax_class'];
    manageStock = json['manage_stock'];
    stockQuantity = json['stock_quantity'];
    backorders = json['backorders'];
    backordersAllowed = json['backorders_allowed'];
    backordered = json['backordered'];
    lowStockAmount = json['low_stock_amount'];
    soldIndividually = json['sold_individually'];
    weight = json['weight'];
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    shippingRequired = json['shipping_required'];
    shippingTaxable = json['shipping_taxable'];
    shippingClass = json['shipping_class'];
    shippingClassId = json['shipping_class_id'];
    reviewsAllowed = json['reviews_allowed'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    // if (json['upsell_ids'] != null) {
    //   upsellIds = [];
    //   json['upsell_ids'].forEach((v) {
    //     upsellIds?.add(Dynamic.fromJson(v));
    //   });
    // }
    // if (json['cross_sell_ids'] != null) {
    //   crossSellIds = [];
    //   json['cross_sell_ids'].forEach((v) {
    //     crossSellIds?.add(Dynamic.fromJson(v));
    //   });
    // }
    parentId = json['parent_id'];
    purchaseNote = json['purchase_note'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    // if (json['brands'] != null) {
    //   brands = [];
    //   json['brands'].forEach((v) {
    //     brands?.add(Dynamic.fromJson(v));
    //   });
    // }
    // if (json['tags'] != null) {
    //   tags = [];
    //   json['tags'].forEach((v) {
    //     tags?.add(Dynamic.fromJson(v));
    //   });
    // }
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes?.add(Attributes.fromJson(v));
      });
    }
    if (json['default_attributes'] != null) {
      defaultAttributes = [];
      json['default_attributes'].forEach((v) {
        defaultAttributes?.add(DefaultAttributes.fromJson(v));
      });
    }
    variations =
        json['variations'] != null ? json['variations'].cast<num>() : [];
    // if (json['grouped_products'] != null) {
    //   groupedProducts = [];
    //   json['grouped_products'].forEach((v) {
    //     groupedProducts?.add(Dynamic.fromJson(v));
    //   });
    // }
    menuOrder = json['menu_order'];
    priceHtml = json['price_html'];
    relatedIds =
        json['related_ids'] != null ? json['related_ids'].cast<num>() : [];
    if (json['meta_data'] != null) {
      metaData = [];
      json['meta_data'].forEach((v) {
        metaData?.add(MetaData.fromJson(v));
      });
    }
    stockStatus = json['stock_status'];
    hasOptions = json['has_options'];
    postPassword = json['post_password'];
    globalUniqueId = json['global_unique_id'];
    jetpackSharingEnabled = json['jetpack_sharing_enabled'];
    links = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }
  num? id;
  String? name;
  String? slug;
  String? permalink;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? type;
  String? status;
  bool? featured;
  String? catalogVisibility;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleFromGmt;
  dynamic dateOnSaleTo;
  dynamic dateOnSaleToGmt;
  bool? onSale;
  bool? purchasable;
  num? totalSales;
  bool? virtual;
  bool? downloadable;
  List<dynamic>? downloads;
  num? downloadLimit;
  num? downloadExpiry;
  String? externalUrl;
  String? buttonText;
  String? taxStatus;
  String? taxClass;
  bool? manageStock;
  dynamic stockQuantity;
  String? backorders;
  bool? backordersAllowed;
  bool? backordered;
  dynamic lowStockAmount;
  bool? soldIndividually;
  String? weight;
  Dimensions? dimensions;
  bool? shippingRequired;
  bool? shippingTaxable;
  String? shippingClass;
  num? shippingClassId;
  bool? reviewsAllowed;
  String? averageRating;
  num? ratingCount;
  List<dynamic>? upsellIds;
  List<dynamic>? crossSellIds;
  num? parentId;
  String? purchaseNote;
  List<Categories>? categories;
  List<dynamic>? brands;
  List<dynamic>? tags;
  List<Images>? images;
  List<Attributes>? attributes;
  List<DefaultAttributes>? defaultAttributes;
  List<num>? variations;
  List<dynamic>? groupedProducts;
  num? menuOrder;
  String? priceHtml;
  List<num>? relatedIds;
  List<MetaData>? metaData;
  String? stockStatus;
  bool? hasOptions;
  String? postPassword;
  String? globalUniqueId;
  bool? jetpackSharingEnabled;
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['permalink'] = permalink;
    map['date_created'] = dateCreated;
    map['date_created_gmt'] = dateCreatedGmt;
    map['date_modified'] = dateModified;
    map['date_modified_gmt'] = dateModifiedGmt;
    map['type'] = type;
    map['status'] = status;
    map['featured'] = featured;
    map['catalog_visibility'] = catalogVisibility;
    map['description'] = description;
    map['short_description'] = shortDescription;
    map['sku'] = sku;
    map['price'] = price;
    map['regular_price'] = regularPrice;
    map['sale_price'] = salePrice;
    map['date_on_sale_from'] = dateOnSaleFrom;
    map['date_on_sale_from_gmt'] = dateOnSaleFromGmt;
    map['date_on_sale_to'] = dateOnSaleTo;
    map['date_on_sale_to_gmt'] = dateOnSaleToGmt;
    map['on_sale'] = onSale;
    map['purchasable'] = purchasable;
    map['total_sales'] = totalSales;
    map['virtual'] = virtual;
    map['downloadable'] = downloadable;
    if (downloads != null) {
      map['downloads'] = downloads?.map((v) => v.toJson()).toList();
    }
    map['download_limit'] = downloadLimit;
    map['download_expiry'] = downloadExpiry;
    map['external_url'] = externalUrl;
    map['button_text'] = buttonText;
    map['tax_status'] = taxStatus;
    map['tax_class'] = taxClass;
    map['manage_stock'] = manageStock;
    map['stock_quantity'] = stockQuantity;
    map['backorders'] = backorders;
    map['backorders_allowed'] = backordersAllowed;
    map['backordered'] = backordered;
    map['low_stock_amount'] = lowStockAmount;
    map['sold_individually'] = soldIndividually;
    map['weight'] = weight;
    if (dimensions != null) {
      map['dimensions'] = dimensions?.toJson();
    }
    map['shipping_required'] = shippingRequired;
    map['shipping_taxable'] = shippingTaxable;
    map['shipping_class'] = shippingClass;
    map['shipping_class_id'] = shippingClassId;
    map['reviews_allowed'] = reviewsAllowed;
    map['average_rating'] = averageRating;
    map['rating_count'] = ratingCount;
    if (upsellIds != null) {
      map['upsell_ids'] = upsellIds?.map((v) => v.toJson()).toList();
    }
    if (crossSellIds != null) {
      map['cross_sell_ids'] = crossSellIds?.map((v) => v.toJson()).toList();
    }
    map['parent_id'] = parentId;
    map['purchase_note'] = purchaseNote;
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    if (brands != null) {
      map['brands'] = brands?.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      map['tags'] = tags?.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    if (attributes != null) {
      map['attributes'] = attributes?.map((v) => v.toJson()).toList();
    }
    if (defaultAttributes != null) {
      map['default_attributes'] =
          defaultAttributes?.map((v) => v.toJson()).toList();
    }
    map['variations'] = variations;
    if (groupedProducts != null) {
      map['grouped_products'] =
          groupedProducts?.map((v) => v.toJson()).toList();
    }
    map['menu_order'] = menuOrder;
    map['price_html'] = priceHtml;
    map['related_ids'] = relatedIds;
    if (metaData != null) {
      map['meta_data'] = metaData?.map((v) => v.toJson()).toList();
    }
    map['stock_status'] = stockStatus;
    map['has_options'] = hasOptions;
    map['post_password'] = postPassword;
    map['global_unique_id'] = globalUniqueId;
    map['jetpack_sharing_enabled'] = jetpackSharingEnabled;
    if (links != null) {
      map['_links'] = links?.toJson();
    }
    return map;
  }
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  Links.fromJson(dynamic json) {
    if (json['self'] != null) {
      self = [];
      json['self'].forEach((v) {
        self?.add(Self.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = [];
      json['collection'].forEach((v) {
        collection?.add(Collection.fromJson(v));
      });
    }
  }
  List<Self>? self;
  List<Collection>? collection;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (self != null) {
      map['self'] = self?.map((v) => v.toJson()).toList();
    }
    if (collection != null) {
      map['collection'] = collection?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Collection {
  Collection({
    this.href,
  });

  Collection.fromJson(dynamic json) {
    href = json['href'];
  }
  String? href;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['href'] = href;
    return map;
  }
}

class Self {
  Self({
    this.href,
    this.targetHints,
  });

  Self.fromJson(dynamic json) {
    href = json['href'];
    targetHints = json['targetHints'] != null
        ? TargetHints.fromJson(json['targetHints'])
        : null;
  }
  String? href;
  TargetHints? targetHints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['href'] = href;
    if (targetHints != null) {
      map['targetHints'] = targetHints?.toJson();
    }
    return map;
  }
}

class TargetHints {
  TargetHints({
    this.allow,
  });

  TargetHints.fromJson(dynamic json) {
    allow = json['allow'] != null ? json['allow'].cast<String>() : [];
  }
  List<String>? allow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allow'] = allow;
    return map;
  }
}

class MetaData {
  MetaData({
    this.id,
    this.key,
    this.value,
  });

  MetaData.fromJson(dynamic json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }
  num? id;
  String? key;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['key'] = key;
    map['value'] = value;
    return map;
  }
}

class DefaultAttributes {
  DefaultAttributes({
    this.id,
    this.name,
    this.option,
  });

  DefaultAttributes.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    option = json['option'];
  }
  num? id;
  String? name;
  String? option;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['option'] = option;
    return map;
  }
}

class Attributes {
  Attributes({
    this.id,
    this.name,
    this.slug,
    this.position,
    this.visible,
    this.variation,
    this.options,
  });

  Attributes.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
    options = json['options'] != null ? json['options'].cast<String>() : [];
  }
  num? id;
  String? name;
  String? slug;
  num? position;
  bool? visible;
  bool? variation;
  List<String>? options;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['position'] = position;
    map['visible'] = visible;
    map['variation'] = variation;
    map['options'] = options;
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

class Categories {
  Categories({
    this.id,
    this.name,
    this.slug,
  });

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

class Dimensions {
  Dimensions({
    this.length,
    this.width,
    this.height,
  });

  Dimensions.fromJson(dynamic json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }
  String? length;
  String? width;
  String? height;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['length'] = length;
    map['width'] = width;
    map['height'] = height;
    return map;
  }
}
