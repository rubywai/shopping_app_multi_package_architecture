class CreateOrderRequest {
  final String? paymentMethod;
  final String? paymentMethodTitle;
  final bool? setPaid;
  final BillingAddress? billing;
  final ShippingAddress? shipping;
  final List<OrderLineItem>? lineItems;
  final List<OrderShippingLine>? shippingLines;
  final String? customerId;
  final String? customerNote;

  CreateOrderRequest({
    this.paymentMethod,
    this.paymentMethodTitle,
    this.setPaid,
    this.billing,
    this.shipping,
    this.lineItems,
    this.shippingLines,
    this.customerId,
    this.customerNote,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (paymentMethod != null) data['payment_method'] = paymentMethod;
    if (paymentMethodTitle != null) {
      data['payment_method_title'] = paymentMethodTitle;
    }
    if (setPaid != null) data['set_paid'] = setPaid;
    if (billing != null) data['billing'] = billing!.toJson();
    if (shipping != null) data['shipping'] = shipping!.toJson();
    if (lineItems != null) {
      data['line_items'] = lineItems!.map((v) => v.toJson()).toList();
    }
    if (shippingLines != null) {
      data['shipping_lines'] = shippingLines!.map((v) => v.toJson()).toList();
    }
    if (customerId != null) data['customer_id'] = customerId;
    if (customerNote != null) data['customer_note'] = customerNote;
    return data;
  }
}

class BillingAddress {
  final String? firstName;
  final String? lastName;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;
  final String? email;
  final String? phone;

  BillingAddress({
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) {
    return BillingAddress(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      address1: json['address_1'] as String?,
      address2: json['address_2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postcode: json['postcode'] as String?,
      country: json['country'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (address1 != null) 'address_1': address1,
      if (address2 != null) 'address_2': address2,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (postcode != null) 'postcode': postcode,
      if (country != null) 'country': country,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
    };
  }
}

class ShippingAddress {
  final String? firstName;
  final String? lastName;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;

  ShippingAddress({
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      address1: json['address_1'] as String?,
      address2: json['address_2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postcode: json['postcode'] as String?,
      country: json['country'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (address1 != null) 'address_1': address1,
      if (address2 != null) 'address_2': address2,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (postcode != null) 'postcode': postcode,
      if (country != null) 'country': country,
    };
  }
}

class OrderLineItem {
  final int? productId;
  final int? quantity;
  final int? variationId;

  OrderLineItem({this.productId, this.quantity, this.variationId});

  factory OrderLineItem.fromJson(Map<String, dynamic> json) {
    return OrderLineItem(
      productId: json['product_id'] as int?,
      quantity: json['quantity'] as int?,
      variationId: json['variation_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (variationId != null) 'variation_id': variationId,
    };
  }
}

class OrderShippingLine {
  final String? methodId;
  final String? methodTitle;
  final String? total;

  OrderShippingLine({this.methodId, this.methodTitle, this.total});

  factory OrderShippingLine.fromJson(Map<String, dynamic> json) {
    return OrderShippingLine(
      methodId: json['method_id'] as String?,
      methodTitle: json['method_title'] as String?,
      total: json['total'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (methodId != null) 'method_id': methodId,
      if (methodTitle != null) 'method_title': methodTitle,
      if (total != null) 'total': total,
    };
  }
}
