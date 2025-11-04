import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../data/services/order_service.dart';
import 'order_list_state_model.dart';

class OrderListStateNotifier extends Notifier<OrderListState> {
  late final OrderService _orderService;

  @override
  OrderListState build() {
    _orderService = GetIt.instance.get<OrderService>();
    return OrderListState();
  }

  Future<void> loadOrders(String customerId, {String? status}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final orders = await _orderService.getOrders(
        customerId: customerId,
        status: status,
      );
      state = state.copyWith(isLoading: false, orders: orders);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final orderListStateNotifierProvider =
    NotifierProvider<OrderListStateNotifier, OrderListState>(
      () => OrderListStateNotifier(),
    );
