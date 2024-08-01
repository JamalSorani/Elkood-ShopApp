part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class FetchOrdersEvent extends OrderEvent {
  final int userId;

  FetchOrdersEvent({required this.userId});
}

class AddOrderEvent extends OrderEvent {
  final List<OrderedProduct> orderedProduct;
  final int userId;
  AddOrderEvent({required this.orderedProduct, required this.userId});
}
