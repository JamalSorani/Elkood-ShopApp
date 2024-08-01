part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderDoneState extends OrderState {
  final List<OrderItem> orders;

  OrderDoneState({
    required this.orders,
  });
}

final class LoadingState extends OrderState {}

final class ErrorState extends OrderState {
  final String message;

  ErrorState({required this.message});
}

final class AddintOrderState extends OrderState {}

final class OrderAddedState extends OrderState {}
