class CustomerModel {
  final int id;
  final String dateCreated;
  final String dateCreatedGmt;
  final String? dateModified;
  final String? dateModifiedGmt;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String username;
  final BillingAddress billing;
  final ShippingAddress shipping;
  final bool isPayingCustomer;
  final String avatarUrl;
  final List<dynamic> metaData;

  CustomerModel({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.username,
    required this.billing,
    required this.shipping,
    required this.isPayingCustomer,
    required this.avatarUrl,
    required this.metaData,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] as int,
      dateCreated: json['date_created'] as String,
      dateCreatedGmt: json['date_created_gmt'] as String,
      dateModified: json['date_modified'] as String?,
      dateModifiedGmt: json['date_modified_gmt'] as String?,
      email: json['email'] as String,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      role: json['role'] as String,
      username: json['username'] as String,
      billing: BillingAddress.fromJson(json['billing'] as Map<String, dynamic>),
      shipping:
          ShippingAddress.fromJson(json['shipping'] as Map<String, dynamic>),
      isPayingCustomer: json['is_paying_customer'] as bool,
      avatarUrl: json['avatar_url'] as String,
      metaData: json['meta_data'] as List<dynamic>? ?? [],
    );
  }

  String get fullName {
    if (firstName.isEmpty && lastName.isEmpty) {
      return username;
    }
    return '${firstName.trim()} ${lastName.trim()}'.trim();
  }
}

class BillingAddress {
  final String firstName;
  final String lastName;
  final String company;
  final String address1;
  final String address2;
  final String city;
  final String postcode;
  final String country;
  final String state;
  final String email;
  final String phone;

  BillingAddress({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.country,
    required this.state,
    required this.email,
    required this.phone,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) {
    return BillingAddress(
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      company: json['company'] as String? ?? '',
      address1: json['address_1'] as String? ?? '',
      address2: json['address_2'] as String? ?? '',
      city: json['city'] as String? ?? '',
      postcode: json['postcode'] as String? ?? '',
      country: json['country'] as String? ?? '',
      state: json['state'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
    );
  }

  bool get hasAddress {
    return address1.isNotEmpty || city.isNotEmpty || country.isNotEmpty;
  }

  String get fullAddress {
    final parts = <String>[];
    if (address1.isNotEmpty) parts.add(address1);
    if (address2.isNotEmpty) parts.add(address2);
    if (city.isNotEmpty) parts.add(city);
    if (state.isNotEmpty) parts.add(state);
    if (postcode.isNotEmpty) parts.add(postcode);
    if (country.isNotEmpty) parts.add(country);
    return parts.join(', ');
  }
}

class ShippingAddress {
  final String firstName;
  final String lastName;
  final String company;
  final String address1;
  final String address2;
  final String city;
  final String postcode;
  final String country;
  final String state;
  final String phone;

  ShippingAddress({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.country,
    required this.state,
    required this.phone,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      company: json['company'] as String? ?? '',
      address1: json['address_1'] as String? ?? '',
      address2: json['address_2'] as String? ?? '',
      city: json['city'] as String? ?? '',
      postcode: json['postcode'] as String? ?? '',
      country: json['country'] as String? ?? '',
      state: json['state'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
    );
  }

  bool get hasAddress {
    return address1.isNotEmpty || city.isNotEmpty || country.isNotEmpty;
  }

  String get fullAddress {
    final parts = <String>[];
    if (address1.isNotEmpty) parts.add(address1);
    if (address2.isNotEmpty) parts.add(address2);
    if (city.isNotEmpty) parts.add(city);
    if (state.isNotEmpty) parts.add(state);
    if (postcode.isNotEmpty) parts.add(postcode);
    if (country.isNotEmpty) parts.add(country);
    return parts.join(', ');
  }
}
