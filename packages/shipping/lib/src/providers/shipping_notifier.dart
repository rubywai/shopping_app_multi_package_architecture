import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/services/shipping_service.dart';
import 'shipping_state.dart';

class ShippingNotifier extends Notifier<ShippingState> {
  final ShippingService _shippingService = ShippingService();

  @override
  ShippingState build() {
    return ShippingInitial();
  }

  Future<void> loadShippingMethods(int zoneId) async {
    state = ShippingLoading();
    try {
      final methods = await _shippingService.getShippingMethods(zoneId);
      state = ShippingSuccess(methods);
    } catch (e) {
      state = ShippingFailed(message: e.toString());
    }
  }
}

final shippingProvider = NotifierProvider<ShippingNotifier, ShippingState>(
  () => ShippingNotifier(),
);
