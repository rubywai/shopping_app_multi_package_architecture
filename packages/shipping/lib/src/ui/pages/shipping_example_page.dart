import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/shipping_method.dart';
import '../widgets/shipping_selector.dart';

/// Example page demonstrating how to use ShippingMethodSelector
/// You can integrate this into your checkout flow
class ShippingExamplePage extends ConsumerStatefulWidget {
  const ShippingExamplePage({super.key});

  @override
  ConsumerState<ShippingExamplePage> createState() =>
      _ShippingExamplePageState();
}

class _ShippingExamplePageState extends ConsumerState<ShippingExamplePage> {
  ShippingMethod? _selectedShipping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Shipping Method')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose your delivery method:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ShippingMethodSelector(
                initialZoneId: 2, // Default zone (Myanmar - zone 2)
                showZoneSelector: false, // Hide zone selector (only one zone)
                onMethodSelected: (method) {
                  setState(() {
                    _selectedShipping = method;
                  });
                },
              ),
            ),
            if (_selectedShipping != null) ...[
              const Divider(),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selected Shipping:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Method: ${_selectedShipping!.title}'),
                    Text('Cost: ${_selectedShipping!.displayCost}'),
                    Text('Method ID: ${_selectedShipping!.methodId}'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Here you would typically:
                    // 1. Add shipping info to order
                    // 2. Navigate to payment/review
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Selected: ${_selectedShipping!.title} - ${_selectedShipping!.displayCost}',
                        ),
                      ),
                    );
                  },
                  child: const Text('Continue to Payment'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
