import '../data/models/create_order_response.dart';

class OrderState {
  final bool isLoading;
  final bool isCreatingOrder;
  final CreateOrderResponse? createdOrder;
  final List<CreateOrderResponse> orders;
  final CreateOrderResponse? selectedOrder;
  final String? error;
  final String? successMessage;

  OrderState({
    this.isLoading = false,
    this.isCreatingOrder = false,
    this.createdOrder,
    this.orders = const [],
    this.selectedOrder,
    this.error,
    this.successMessage,
  });

  OrderState copyWith({
    bool? isLoading,
    bool? isCreatingOrder,
    CreateOrderResponse? createdOrder,
    List<CreateOrderResponse>? orders,
    CreateOrderResponse? selectedOrder,
    String? error,
    String? successMessage,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      isCreatingOrder: isCreatingOrder ?? this.isCreatingOrder,
      createdOrder: createdOrder ?? this.createdOrder,
      orders: orders ?? this.orders,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      error: error,
      successMessage: successMessage,
    );
  }
}
