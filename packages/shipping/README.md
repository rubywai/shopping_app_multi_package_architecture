# Shipping Package

Shipping methods feature package for WooCommerce-based Flutter shopping app.

## Features

- Fetch shipping methods from WooCommerce API by zone
- Display shipping options with radio selection UI
- Handle free shipping and paid shipping methods
- Riverpod state management
- Loading, success, and error states

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  shipping:
    path: ../packages/shipping
```

## Setup

### 1. Register Dio in Dependency Injection

The shipping package expects a Dio instance with the name 'shipping' registered in GetIt.

```dart
// In your DI setup (e.g., packages/common/lib/src/dependency/di.dart)
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

Future<void> setUpCommonDependency() async {
  GetIt getIt = GetIt.instance;
  
  Dio shippingDio = Dio();
  shippingDio.options.baseUrl = 'YOUR_BASE_URL';
  shippingDio.options.connectTimeout = const Duration(seconds: 30);
  shippingDio.options.receiveTimeout = const Duration(seconds: 30);
  
  getIt.registerSingleton<Dio>(
    shippingDio,
    instanceName: 'shipping',
  );
}
```

### 2. Call DI setup before running app

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpCommonDependency();
  runApp(MyApp());
}
```

## Usage

### Basic Usage in Checkout Flow

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shipping/shipping.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  ShippingMethod? selectedShipping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ShippingMethodSelector(
            zoneId: 1,
            onMethodSelected: (method) {
              setState(() {
                selectedShipping = method;
              });
            },
          ),
          
          if (selectedShipping != null)
            Text('Selected: ${selectedShipping!.displayCost}'),
        ],
      ),
    );
  }
}
```

### Using Selected Shipping in Order Creation

```dart
// When creating order, include shipping_lines
{
  "shipping_lines": [
    {
      "method_id": selectedShipping.methodId,
      "method_title": selectedShipping.methodTitle,
      "total": selectedShipping.totalCost
    }
  ]
}
```

### Accessing Shipping State Directly

```dart
final shippingState = ref.watch(shippingProvider);

if (shippingState is ShippingLoading) {
  // Show loading
} else if (shippingState is ShippingSuccess) {
  final methods = shippingState.methods;
  // Display methods manually
} else if (shippingState is ShippingFailed) {
  // Show error
}
```

## API Structure

### WooCommerce Shipping Endpoint

GET `/api.php?endpoint=shipping/zones/{zoneId}/methods`

Response example:

```json
[
  {
    "id": 4,
    "instance_id": 4,
    "title": "နယ်မြို့",
    "order": 1,
    "enabled": true,
    "method_id": "flat_rate",
    "method_title": "Flat rate",
    "method_description": "Flat rate shipping",
    "settings": {
      "cost": {
        "value": "20"
      }
    }
  },
  {
    "id": 5,
    "instance_id": 5,
    "title": "Free shipping",
    "order": 2,
    "enabled": true,
    "method_id": "free_shipping",
    "method_title": "Free shipping",
    "method_description": "",
    "settings": {}
  }
]
```

## Components

### ShippingMethod Model

Properties:
- `id` - Shipping method ID
- `instanceId` - Instance ID
- `title` - Display title
- `methodId` - Method identifier (e.g., "flat_rate")
- `methodTitle` - Method title
- `cost` - Cost as string (null = free)
- `displayCost` - Formatted cost for UI (e.g., "20 Ks" or "Free")
- `totalCost` - Cost for order API (string "0" if free)

### ShippingMethodSelector Widget

A reusable widget that displays shipping methods with radio selection.

Parameters:
- `onMethodSelected` - Callback when method is selected
- `initialValue` - Pre-selected method (optional)
- `zoneId` - WooCommerce shipping zone ID (default: 1)

### ShippingNotifier

Riverpod StateNotifier for managing shipping state.

Methods:
- `loadShippingMethods(int zoneId)` - Fetch shipping methods

### ShippingState

State classes:
- `ShippingInitial` - Initial state
- `ShippingLoading` - Loading methods
- `ShippingSuccess` - Methods loaded successfully
- `ShippingFailed` - Error occurred

## Notes

- Cost is extracted from `settings.cost.value` in API response
- If cost is null, empty, or "0", it's displayed as "Free"
- Zone ID typically represents geographic regions (e.g., 1 = Myanmar)
- Currency symbol (Ks) is hardcoded; customize in `ShippingMethod.displayCost` if needed

