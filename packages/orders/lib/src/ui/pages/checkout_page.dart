// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cart/cart.dart';
import 'package:shipping/shipping.dart';
import 'package:profile/profile.dart' as profile;
import 'package:auth/auth.dart';
import '../../data/models/create_order_request.dart';
import '../../providers/order_state_model.dart';
import '../../providers/order_state_notifier.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  // Billing fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postcodeController = TextEditingController();
  final _countryController = TextEditingController(text: 'MM');

  // Shipping
  bool _sameAsBilling = true;
  ShippingMethod? _selectedShippingMethod;
  final _shippingFirstNameController = TextEditingController();
  final _shippingLastNameController = TextEditingController();
  final _shippingAddress1Controller = TextEditingController();
  final _shippingAddress2Controller = TextEditingController();
  final _shippingCityController = TextEditingController();
  final _shippingStateController = TextEditingController();
  final _shippingPostcodeController = TextEditingController();
  final _shippingCountryController = TextEditingController(text: 'MM');

  // Payment
  String _selectedPaymentMethod = 'cod';

  // Order note
  final _orderNoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Check authentication and load customer data when checkout page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthAndLoadData();
    });
  }

  Future<void> _checkAuthAndLoadData() async {
    final authState = ref.read(authStateNotifierProvider);

    // If user is not authenticated, redirect to login
    if (!authState.isAuthenticated) {
      if (mounted) {
        context.pushReplacement('/login');
      }
      return;
    }

    // User is authenticated, load customer data
    await _loadCustomerData();
  }

  Future<void> _loadCustomerData() async {
    final authState = ref.read(authStateNotifierProvider);
    if (authState.isAuthenticated && authState.userData != null) {
      final userId = authState.userData!.id;
      if (userId != null) {
        await ref
            .read(profile.profileStateNotifierProvider.notifier)
            .loadProfile(userId);

        // Pre-fill form fields with customer data
        final profileState = ref.read(profile.profileStateNotifierProvider);
        if (profileState.customer != null) {
          final customer = profileState.customer!;

          // Fill billing details
          _firstNameController.text = customer.billing.firstName.isNotEmpty
              ? customer.billing.firstName
              : customer.firstName;
          _lastNameController.text = customer.billing.lastName.isNotEmpty
              ? customer.billing.lastName
              : customer.lastName;
          _emailController.text = customer.billing.email.isNotEmpty
              ? customer.billing.email
              : customer.email;
          _phoneController.text = customer.billing.phone;
          _address1Controller.text = customer.billing.address1;
          _address2Controller.text = customer.billing.address2;
          _cityController.text = customer.billing.city;
          _stateController.text = customer.billing.state;
          _postcodeController.text = customer.billing.postcode;
          _countryController.text = customer.billing.country.isNotEmpty
              ? customer.billing.country
              : 'MM';

          // Fill shipping details
          // If shipping fields are empty, fallback to billing/profile values
          _shippingFirstNameController.text =
              customer.shipping.firstName.isNotEmpty
              ? customer.shipping.firstName
              : (customer.billing.firstName.isNotEmpty
                    ? customer.billing.firstName
                    : customer.firstName);

          _shippingLastNameController.text =
              customer.shipping.lastName.isNotEmpty
              ? customer.shipping.lastName
              : (customer.billing.lastName.isNotEmpty
                    ? customer.billing.lastName
                    : customer.lastName);

          _shippingAddress1Controller.text =
              customer.shipping.address1.isNotEmpty
              ? customer.shipping.address1
              : customer.billing.address1;

          _shippingAddress2Controller.text =
              customer.shipping.address2.isNotEmpty
              ? customer.shipping.address2
              : customer.billing.address2;

          _shippingCityController.text = customer.shipping.city.isNotEmpty
              ? customer.shipping.city
              : customer.billing.city;

          _shippingStateController.text = customer.shipping.state.isNotEmpty
              ? customer.shipping.state
              : customer.billing.state;

          _shippingPostcodeController.text =
              customer.shipping.postcode.isNotEmpty
              ? customer.shipping.postcode
              : customer.billing.postcode;

          _shippingCountryController.text = customer.shipping.country.isNotEmpty
              ? customer.shipping.country
              : (customer.billing.country.isNotEmpty
                    ? customer.billing.country
                    : 'MM');
        }
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postcodeController.dispose();
    _countryController.dispose();
    _shippingFirstNameController.dispose();
    _shippingLastNameController.dispose();
    _shippingAddress1Controller.dispose();
    _shippingAddress2Controller.dispose();
    _shippingCityController.dispose();
    _shippingStateController.dispose();
    _shippingPostcodeController.dispose();
    _shippingCountryController.dispose();
    _orderNoteController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Get the current logged-in user's ID
    final authState = ref.read(authStateNotifierProvider);
    final userIdString = authState.userData?.id;

    if (userIdString == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to place an order'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Parse userId from String to int
    final customerId = int.tryParse(userIdString);
    if (customerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid user ID'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final cartState = ref.read(cartStateNotifierProvider);
    if (cartState.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Prepare line items from cart
    final lineItems = cartState.items.map((item) {
      return OrderLineItem(
        productId: item.productId,
        quantity: item.quantity,
        variationId: item.variationId,
      );
    }).toList();

    // Prepare billing address
    final billing = BillingAddress(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      address1: _address1Controller.text.trim(),
      address2: _address2Controller.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      postcode: _postcodeController.text.trim(),
      country: _countryController.text.trim(),
    );

    // Prepare shipping address
    ShippingAddress? shipping;
    if (_sameAsBilling) {
      shipping = ShippingAddress(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        address1: _address1Controller.text.trim(),
        address2: _address2Controller.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        postcode: _postcodeController.text.trim(),
        country: _countryController.text.trim(),
      );
    } else {
      shipping = ShippingAddress(
        firstName: _shippingFirstNameController.text.trim(),
        lastName: _shippingLastNameController.text.trim(),
        address1: _shippingAddress1Controller.text.trim(),
        address2: _shippingAddress2Controller.text.trim(),
        city: _shippingCityController.text.trim(),
        state: _shippingStateController.text.trim(),
        postcode: _shippingPostcodeController.text.trim(),
        country: _shippingCountryController.text.trim(),
      );
    }

    // Validate shipping method is selected
    if (_selectedShippingMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a shipping method'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final orderRequest = CreateOrderRequest(
      paymentMethod: _selectedPaymentMethod,
      paymentMethodTitle: _selectedPaymentMethod == 'cod'
          ? 'Cash on Delivery'
          : 'Direct Bank Transfer',
      setPaid: false,
      billing: billing,
      shipping: shipping,
      lineItems: lineItems,
      shippingLines: [
        OrderShippingLine(
          methodId: _selectedShippingMethod!.methodId,
          methodTitle: _selectedShippingMethod!.methodTitle,
          total: _selectedShippingMethod!.totalCost,
        ),
      ],
      customerId: customerId, // Pass as integer directly
      customerNote: _orderNoteController.text.trim().isNotEmpty
          ? _orderNoteController.text.trim()
          : null,
    );

    // Capture context-dependent handlers before the async call to avoid
    // using BuildContext across an async gap.
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);

    final success = await ref
        .read(orderStateNotifierProvider.notifier)
        .createOrder(orderRequest);

    if (!mounted) return;

    if (success) {
      final orderState = ref.read(orderStateNotifierProvider);

      // Clear cart after successful order
      await ref.read(cartStateNotifierProvider.notifier).clearCart();

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            orderState.successMessage ?? 'Order placed successfully!',
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'View Orders',
            textColor: Colors.white,
            onPressed: () {
              router.go('/orders');
            },
          ),
        ),
      );

      // Navigate to products
      router.go('/products');
    } else {
      final error = ref.read(orderStateNotifierProvider).error;
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(error ?? 'Failed to place order'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartStateNotifierProvider);
    final orderState = ref.watch(orderStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: cartState.items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Billing Details'),
                          const SizedBox(height: 16),
                          _buildBillingForm(),
                          const SizedBox(height: 24),
                          _buildShippingSection(),
                          const SizedBox(height: 24),
                          _buildSectionTitle('Payment Method'),
                          const SizedBox(height: 16),
                          _buildPaymentMethods(),
                          const SizedBox(height: 24),
                          _buildSectionTitle('Order Notes (Optional)'),
                          const SizedBox(height: 16),
                          _buildOrderNoteField(),
                          const SizedBox(height: 24),
                          _buildSectionTitle('Order Summary'),
                          const SizedBox(height: 16),
                          _buildOrderSummary(cartState),
                        ],
                      ),
                    ),
                  ),
                  _buildPlaceOrderButton(orderState),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBillingForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email *',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Required';
            if (!value!.contains('@')) return 'Invalid email';
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Phone *',
            border: OutlineInputBorder(),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _address1Controller,
          decoration: const InputDecoration(
            labelText: 'Address Line 1 *',
            border: OutlineInputBorder(),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _address2Controller,
          decoration: const InputDecoration(
            labelText: 'Address Line 2',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(
                  labelText: 'State *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _postcodeController,
                decoration: const InputDecoration(
                  labelText: 'Postcode *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(
                  labelText: 'Country *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShippingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Shipping Details'),
        const SizedBox(height: 16),
        CheckboxListTile(
          title: const Text('Same as billing address'),
          value: _sameAsBilling,
          onChanged: (value) {
            setState(() {
              _sameAsBilling = value ?? true;
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
        if (!_sameAsBilling) ...[
          const SizedBox(height: 16),
          _buildShippingForm(),
        ],
        const SizedBox(height: 24),
        _buildSectionTitle('Delivery Method'),
        const SizedBox(height: 16),
        ShippingMethodSelector(
          initialZoneId: 2,
          showZoneSelector:
              false, // Hide zone selector since we only have Myanmar
          onMethodSelected: (method) {
            setState(() {
              _selectedShippingMethod = method;
            });
          },
        ),
      ],
    );
  }

  Widget _buildShippingForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _shippingFirstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    !_sameAsBilling && (value?.isEmpty ?? true)
                    ? 'Required'
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _shippingLastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    !_sameAsBilling && (value?.isEmpty ?? true)
                    ? 'Required'
                    : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _shippingAddress1Controller,
          decoration: const InputDecoration(
            labelText: 'Address Line 1 *',
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              !_sameAsBilling && (value?.isEmpty ?? true) ? 'Required' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _shippingAddress2Controller,
          decoration: const InputDecoration(
            labelText: 'Address Line 2',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _shippingCityController,
                decoration: const InputDecoration(
                  labelText: 'City *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    !_sameAsBilling && (value?.isEmpty ?? true)
                    ? 'Required'
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _shippingStateController,
                decoration: const InputDecoration(
                  labelText: 'State *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    !_sameAsBilling && (value?.isEmpty ?? true)
                    ? 'Required'
                    : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _shippingPostcodeController,
                decoration: const InputDecoration(
                  labelText: 'Postcode *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    !_sameAsBilling && (value?.isEmpty ?? true)
                    ? 'Required'
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _shippingCountryController,
                decoration: const InputDecoration(
                  labelText: 'Country *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    !_sameAsBilling && (value?.isEmpty ?? true)
                    ? 'Required'
                    : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      children: [
        RadioListTile<String>(
          title: const Text('Cash on Delivery'),
          subtitle: const Text('Pay when you receive your order'),
          value: 'cod',
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Direct Bank Transfer'),
          subtitle: const Text('Transfer directly to our bank account'),
          value: 'bacs',
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildOrderNoteField() {
    return TextFormField(
      controller: _orderNoteController,
      maxLines: 4,
      decoration: const InputDecoration(
        labelText: 'Order Notes',
        hintText: 'Notes about your order, e.g. special notes for delivery',
        border: OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _buildOrderSummary(CartState cartState) {
    final subtotal = cartState.totalPrice;
    final shippingCost = _selectedShippingMethod != null
        ? double.tryParse(_selectedShippingMethod!.totalCost) ?? 0.0
        : 0.0;
    final total = subtotal + shippingCost;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...cartState.items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${item.productName} × ${item.quantity}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      '${item.totalPrice.toStringAsFixed(2)} Ks',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text('${subtotal.toStringAsFixed(2)} Ks'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedShippingMethod != null
                      ? 'Shipping (${_selectedShippingMethod!.title})'
                      : 'Shipping',
                ),
                Text(
                  _selectedShippingMethod != null
                      ? _selectedShippingMethod!.displayCost
                      : 'Not selected',
                  style: TextStyle(
                    color: _selectedShippingMethod == null
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${total.toStringAsFixed(2)} Ks',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceOrderButton(OrderState orderState) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: orderState.isCreatingOrder ? null : _placeOrder,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: orderState.isCreatingOrder
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Place Order', style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
