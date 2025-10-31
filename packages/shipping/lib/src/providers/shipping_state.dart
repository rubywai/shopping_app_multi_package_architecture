import '../data/models/shipping_method.dart';

abstract class ShippingState {}

class ShippingInitial extends ShippingState {}

class ShippingLoading extends ShippingState {}

class ShippingSuccess extends ShippingState {
  final List<ShippingMethod> methods;
  ShippingSuccess(this.methods);
}

class ShippingFailed extends ShippingState {
  final String? message;
  ShippingFailed({this.message});
}
