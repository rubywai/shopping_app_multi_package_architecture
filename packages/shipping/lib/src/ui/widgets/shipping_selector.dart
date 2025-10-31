// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/shipping_method.dart';
import '../../providers/shipping_notifier.dart';
import '../../providers/shipping_state.dart';

class ShippingMethodSelector extends ConsumerStatefulWidget {
  final Function(ShippingMethod) onMethodSelected;
  final ShippingMethod? initialValue;
  final int? initialZoneId;
  final bool showZoneSelector;

  const ShippingMethodSelector({
    super.key,
    required this.onMethodSelected,
    this.initialValue,
    this.initialZoneId,
    this.showZoneSelector = true,
  });

  @override
  ConsumerState<ShippingMethodSelector> createState() =>
      _ShippingMethodSelectorState();
}

class _ShippingMethodSelectorState
    extends ConsumerState<ShippingMethodSelector> {
  ShippingMethod? _selectedMethod;
  int? _selectedZoneId;

  // Define available zones
  final List<Map<String, dynamic>> _availableZones = [
    {
      'id': 2,
      'name': 'Myanmar',
      'description': 'Local delivery within Myanmar',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.initialValue;
    _selectedZoneId = widget.initialZoneId ?? 2; // Default to zone 2

    // Load shipping methods when widget initializes
    Future.microtask(() {
      if (_selectedZoneId != null) {
        ref
            .read(shippingProvider.notifier)
            .loadShippingMethods(_selectedZoneId!);
      }
    });
  }

  void _onZoneChanged(int? newZoneId) {
    if (newZoneId != null && newZoneId != _selectedZoneId) {
      setState(() {
        _selectedZoneId = newZoneId;
        _selectedMethod = null; // Reset selected method when zone changes
      });
      ref.read(shippingProvider.notifier).loadShippingMethods(newZoneId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shippingProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Zone Selector
        if (widget.showZoneSelector) ...[
          const Text(
            'Shipping Zone',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<int>(
              value: _selectedZoneId,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              icon: const Icon(Icons.arrow_drop_down),
              items: _availableZones.map((zone) {
                return DropdownMenuItem<int>(
                  value: zone['id'] as int,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        zone['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      if (zone['description'] != null)
                        Text(
                          zone['description'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: _onZoneChanged,
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Shipping Methods Title
        const Text(
          'Delivery Method',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // Shipping Methods List
        if (state is ShippingLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          )
        else if (state is ShippingFailed)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Failed to load shipping methods',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      if (_selectedZoneId != null) {
                        ref
                            .read(shippingProvider.notifier)
                            .loadShippingMethods(_selectedZoneId!);
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          )
        else if (state is ShippingSuccess)
          state.methods.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No shipping methods available for this zone'),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: state.methods.map((method) {
                    final isSelected = _selectedMethod?.id == method.id;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Text(
                          method.title,
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        subtitle: method.methodDescription.isNotEmpty
                            ? Text(
                                method.methodDescription,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              )
                            : null,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              method.displayCost,
                              style: TextStyle(
                                color: method.cost == null || method.cost == '0'
                                    ? Colors.green
                                    : Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Radio<ShippingMethod>(
                              value: method,
                              groupValue: _selectedMethod,
                              onChanged: (ShippingMethod? value) {
                                setState(() {
                                  _selectedMethod = value;
                                });
                                if (value != null) {
                                  widget.onMethodSelected(value);
                                }
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _selectedMethod = method;
                          });
                          widget.onMethodSelected(method);
                        },
                      ),
                    );
                  }).toList(),
                )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
