class CreateOrderResponse {
  final int? id;
  final int? parentId;
  final String? number;
  final String? orderKey;
  final String? createdVia;
  final String? version;
  final String? status;
  final String? currency;
  final String? dateCreated;
  final String? dateCreatedGmt;
  final String? dateModified;
  final String? dateModifiedGmt;
  final String? discountTotal;
  final String? discountTax;
  final String? shippingTotal;
  final String? shippingTax;
  final String? cartTax;
  final String? total;
  final String? totalTax;
  final bool? pricesIncludeTax;
  final int? customerId;
  final String? customerIpAddress;
  final String? customerUserAgent;
  final String? customerNote;
  final OrderBilling? billing;
  final OrderShipping? shipping;
  final String? paymentMethod;
  final String? paymentMethodTitle;
  final String? transactionId;
  final String? datePaid;
  final String? datePaidGmt;
  final String? cartHash;
  final List<OrderMetaData>? metaData;
  final List<OrderLineItemResponse>? lineItems;
  final List<OrderTaxLine>? taxLines;
  final List<OrderShippingLineResponse>? shippingLines;

  CreateOrderResponse({
    this.id,
    this.parentId,
    this.number,
    this.orderKey,
    this.createdVia,
    this.version,
    this.status,
    this.currency,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.discountTotal,
    this.discountTax,
    this.shippingTotal,
    this.shippingTax,
    this.cartTax,
    this.total,
    this.totalTax,
    this.pricesIncludeTax,
    this.customerId,
    this.customerIpAddress,
    this.customerUserAgent,
    this.customerNote,
    this.billing,
    this.shipping,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.transactionId,
    this.datePaid,
    this.datePaidGmt,
    this.cartHash,
    this.metaData,
    this.lineItems,
    this.taxLines,
    this.shippingLines,
  });

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponse(
      id: json['id'] as int?,
      parentId: json['parent_id'] as int?,
      number: json['number'] as String?,
      orderKey: json['order_key'] as String?,
      createdVia: json['created_via'] as String?,
      version: json['version'] as String?,
      status: json['status'] as String?,
      currency: json['currency'] as String?,
      dateCreated: json['date_created'] as String?,
      dateCreatedGmt: json['date_created_gmt'] as String?,
      dateModified: json['date_modified'] as String?,
      dateModifiedGmt: json['date_modified_gmt'] as String?,
      discountTotal: json['discount_total'] as String?,
      discountTax: json['discount_tax'] as String?,
      shippingTotal: json['shipping_total'] as String?,
      shippingTax: json['shipping_tax'] as String?,
      cartTax: json['cart_tax'] as String?,
      total: json['total'] as String?,
      totalTax: json['total_tax'] as String?,
      pricesIncludeTax: json['prices_include_tax'] as bool?,
      customerId: json['customer_id'] as int?,
      customerIpAddress: json['customer_ip_address'] as String?,
      customerUserAgent: json['customer_user_agent'] as String?,
      customerNote: json['customer_note'] as String?,
      billing: json['billing'] != null
          ? OrderBilling.fromJson(json['billing'])
          : null,
      shipping: json['shipping'] != null
          ? OrderShipping.fromJson(json['shipping'])
          : null,
      paymentMethod: json['payment_method'] as String?,
      paymentMethodTitle: json['payment_method_title'] as String?,
      transactionId: json['transaction_id'] as String?,
      datePaid: json['date_paid'] as String?,
      datePaidGmt: json['date_paid_gmt'] as String?,
      cartHash: json['cart_hash'] as String?,
      metaData: json['meta_data'] != null
          ? (json['meta_data'] as List)
              .map((e) => OrderMetaData.fromJson(e))
              .toList()
          : null,
      lineItems: json['line_items'] != null
          ? (json['line_items'] as List)
              .map((e) => OrderLineItemResponse.fromJson(e))
              .toList()
          : null,
      taxLines: json['tax_lines'] != null
          ? (json['tax_lines'] as List)
              .map((e) => OrderTaxLine.fromJson(e))
              .toList()
          : null,
      shippingLines: json['shipping_lines'] != null
          ? (json['shipping_lines'] as List)
              .map((e) => OrderShippingLineResponse.fromJson(e))
              .toList()
          : null,
    );
  }
}

class OrderBilling {
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;
  final String? email;
  final String? phone;

  OrderBilling({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  factory OrderBilling.fromJson(Map<String, dynamic> json) {
    return OrderBilling(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      company: json['company'] as String?,
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
}

class OrderShipping {
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;

  OrderShipping({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
  });

  factory OrderShipping.fromJson(Map<String, dynamic> json) {
    return OrderShipping(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      company: json['company'] as String?,
      address1: json['address_1'] as String?,
      address2: json['address_2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postcode: json['postcode'] as String?,
      country: json['country'] as String?,
    );
  }
}

class OrderMetaData {
  final int? id;
  final String? key;
  final dynamic value;

  OrderMetaData({this.id, this.key, this.value});

  factory OrderMetaData.fromJson(Map<String, dynamic> json) {
    return OrderMetaData(
      id: json['id'] as int?,
      key: json['key'] as String?,
      value: json['value'],
    );
  }
}

class OrderLineItemResponse {
  final int? id;
  final String? name;
  final int? productId;
  final int? variationId;
  final int? quantity;
  final String? taxClass;
  final String? subtotal;
  final String? subtotalTax;
  final String? total;
  final String? totalTax;
  final List<OrderMetaData>? metaData;

  OrderLineItemResponse({
    this.id,
    this.name,
    this.productId,
    this.variationId,
    this.quantity,
    this.taxClass,
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.totalTax,
    this.metaData,
  });

  factory OrderLineItemResponse.fromJson(Map<String, dynamic> json) {
    return OrderLineItemResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      productId: json['product_id'] as int?,
      variationId: json['variation_id'] as int?,
      quantity: json['quantity'] as int?,
      taxClass: json['tax_class'] as String?,
      subtotal: json['subtotal'] as String?,
      subtotalTax: json['subtotal_tax'] as String?,
      total: json['total'] as String?,
      totalTax: json['total_tax'] as String?,
      metaData: json['meta_data'] != null
          ? (json['meta_data'] as List)
              .map((e) => OrderMetaData.fromJson(e))
              .toList()
          : null,
    );
  }
}

class OrderTaxLine {
  final int? id;
  final String? rateCode;
  final String? rateId;
  final String? label;
  final bool? compound;
  final String? taxTotal;
  final String? shippingTaxTotal;
  final List<OrderMetaData>? metaData;

  OrderTaxLine({
    this.id,
    this.rateCode,
    this.rateId,
    this.label,
    this.compound,
    this.taxTotal,
    this.shippingTaxTotal,
    this.metaData,
  });

  factory OrderTaxLine.fromJson(Map<String, dynamic> json) {
    return OrderTaxLine(
      id: json['id'] as int?,
      rateCode: json['rate_code'] as String?,
      rateId: json['rate_id'] as String?,
      label: json['label'] as String?,
      compound: json['compound'] as bool?,
      taxTotal: json['tax_total'] as String?,
      shippingTaxTotal: json['shipping_tax_total'] as String?,
      metaData: json['meta_data'] != null
          ? (json['meta_data'] as List)
              .map((e) => OrderMetaData.fromJson(e))
              .toList()
          : null,
    );
  }
}

class OrderShippingLineResponse {
  final int? id;
  final String? methodTitle;
  final String? methodId;
  final String? total;
  final String? totalTax;
  final List<OrderMetaData>? metaData;

  OrderShippingLineResponse({
    this.id,
    this.methodTitle,
    this.methodId,
    this.total,
    this.totalTax,
    this.metaData,
  });

  factory OrderShippingLineResponse.fromJson(Map<String, dynamic> json) {
    return OrderShippingLineResponse(
      id: json['id'] as int?,
      methodTitle: json['method_title'] as String?,
      methodId: json['method_id'] as String?,
      total: json['total'] as String?,
      totalTax: json['total_tax'] as String?,
      metaData: json['meta_data'] != null
          ? (json['meta_data'] as List)
              .map((e) => OrderMetaData.fromJson(e))
              .toList()
          : null,
    );
  }
}

