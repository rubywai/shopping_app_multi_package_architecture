class ShippingMethod {
  final int id;
  final int instanceId;
  final String title;
  final int order;
  final bool enabled;
  final String methodId;
  final String methodTitle;
  final String methodDescription;
  final String? cost;

  ShippingMethod({
    required this.id,
    required this.instanceId,
    required this.title,
    required this.order,
    required this.enabled,
    required this.methodId,
    required this.methodTitle,
    required this.methodDescription,
    this.cost,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    // Extract cost safely from nested settings
    String? cost;
    try {
      cost = json['settings']?['cost']?['value']?.toString();
    } catch (e) {
      cost = null;
    }

    return ShippingMethod(
      id: json['id'] ?? 0,
      instanceId: json['instance_id'] ?? 0,
      title: json['title'] ?? json['method_title'] ?? '',
      order: json['order'] ?? 0,
      enabled: json['enabled'] ?? false,
      methodId: json['method_id'] ?? '',
      methodTitle: json['method_title'] ?? json['title'] ?? '',
      methodDescription: json['method_description'] ?? '',
      cost: cost,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'instance_id': instanceId,
      'title': title,
      'order': order,
      'enabled': enabled,
      'method_id': methodId,
      'method_title': methodTitle,
      'method_description': methodDescription,
      'cost': cost,
    };
  }

  // For display in UI
  String get displayCost {
    if (cost == null || cost == '0' || cost!.isEmpty) {
      return 'Free';
    }
    return '$cost Ks';
  }

  // For order creation
  String get totalCost {
    return cost ?? '0';
  }
}
