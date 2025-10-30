class CategoryModel {
  final int? id;
  final String? name;
  final String? slug;
  final int? parent;
  final String? description;
  final String? display;
  final CategoryImage? image;
  final int? menuOrder;
  final int? count;

  CategoryModel({
    this.id,
    this.name,
    this.slug,
    this.parent,
    this.description,
    this.display,
    this.image,
    this.menuOrder,
    this.count,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      parent: json['parent'],
      description: json['description'],
      display: json['display'],
      image:
          json['image'] != null ? CategoryImage.fromJson(json['image']) : null,
      menuOrder: json['menu_order'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'parent': parent,
      'description': description,
      'display': display,
      'image': image?.toJson(),
      'menu_order': menuOrder,
      'count': count,
    };
  }
}

class CategoryImage {
  final int? id;
  final String? src;
  final String? name;
  final String? alt;

  CategoryImage({
    this.id,
    this.src,
    this.name,
    this.alt,
  });

  factory CategoryImage.fromJson(Map<String, dynamic> json) {
    return CategoryImage(
      id: json['id'],
      src: json['src'],
      name: json['name'],
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'src': src,
      'name': name,
      'alt': alt,
    };
  }
}
