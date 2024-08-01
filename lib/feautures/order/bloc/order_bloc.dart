import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../orders_api.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrdersApi ordersApi;
  OrderBloc({required this.ordersApi}) : super(LoadingState()) {
    on<OrderEvent>((event, emit) async {
      if (event is FetchOrdersEvent) {
        emit(LoadingState());
        try {
          final orders = await ordersApi.fetchAndSetOrders(event.userId);
          emit(OrderDoneState(orders: orders));
        } catch (error) {
          print(error.toString());
          emit(ErrorState(message: error.toString()));
        }
      } else if (event is AddOrderEvent) {
        emit(AddintOrderState());
        try {
          await ordersApi.addOrder(event.orderedProduct, event.userId);
          emit(OrderAddedState());
        } catch (error) {
          print('error    ${error.toString()}');
          emit(ErrorState(message: error.toString()));
        }
      }
    });
  }
}
