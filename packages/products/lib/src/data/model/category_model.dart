class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
    this.count,
  });

  CategoryModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    count = json['count'];
  }

  num? id;
  String? name;
  num? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['count'] = count;
    return map;
  }
}
