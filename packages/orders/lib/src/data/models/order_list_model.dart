class OrderListModel {
  final int id;
  final String? status;
  final String total;
  final String dateCreated;
  final List<OrderListLineItem> lineItems;

  OrderListModel({
    required this.id,
    this.status,
    required this.total,
    required this.dateCreated,
    required this.lineItems,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      id: json['id'],
      status: json['status'],
      total: json['total'],
      dateCreated: json['date_created'],
      lineItems: (json['line_items'] as List)
          .map((item) => OrderListLineItem.fromJson(item))
          .toList(),
    );
  }
}

class OrderListLineItem {
  final int id;
  final String name;
  final int quantity;
  final String total;

  OrderListLineItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.total,
  });

  factory OrderListLineItem.fromJson(Map<String, dynamic> json) {
    return OrderListLineItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      total: json['total'],
    );
  }
}
