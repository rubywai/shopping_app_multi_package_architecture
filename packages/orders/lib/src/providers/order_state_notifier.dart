import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../data/models/create_order_request.dart';
import '../data/services/order_service.dart';
import 'order_state_model.dart';

class OrderStateNotifier extends Notifier<OrderState> {
  late final OrderService _orderService;

  @override
  OrderState build() {
    _orderService = GetIt.instance.get<OrderService>();
    return OrderState();
  }

  Future<bool> createOrder(CreateOrderRequest request) async {
    state = state.copyWith(isCreatingOrder: true, error: null);
    try {
      final response = await _orderService.createOrder(request);
      state = state.copyWith(
        isCreatingOrder: false,
        createdOrder: response,
        successMessage: 'Order created successfully! Order #${response.number}',
      );
      return true;
    } catch (e) {
      state = state.copyWith(isCreatingOrder: false, error: e.toString());
      return false;
    }
  }

  Future<void> loadOrderById(int orderId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final order = await _orderService.getOrderById(id: orderId);
      state = state.copyWith(isLoading: false, selectedOrder: order);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearMessages() {
    state = state.copyWith(error: null, successMessage: null);
  }

  void clearCreatedOrder() {
    state = state.copyWith(createdOrder: null);
  }
}

final orderStateNotifierProvider =
    NotifierProvider<OrderStateNotifier, OrderState>(
      () => OrderStateNotifier(),
    );
