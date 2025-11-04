import '../data/models/order_list_model.dart';

class OrderListState {
  final bool isLoading;
  final List<OrderListModel> orders;
  final String? error;

  OrderListState({this.isLoading = false, this.orders = const [], this.error});

  OrderListState copyWith({
    bool? isLoading,
    List<OrderListModel>? orders,
    String? error,
  }) {
    return OrderListState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      error: error,
    );
  }
}
