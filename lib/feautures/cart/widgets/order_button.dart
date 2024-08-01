import 'package:elkood_shop_app/feautures/auth/bloc/auth_bloc.dart';
import 'package:elkood_shop_app/feautures/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../order/orders_api.dart';
import '../cubit/cart_cubit.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({super.key, required this.cart});
  final Map<int, CartItem> cart;
  @override
  OrderButtonState createState() => OrderButtonState();
}

class OrderButtonState extends State<OrderButton> {
  List<OrderedProduct> convertCartMapToList() {
    return widget.cart.entries.map((entry) {
      return OrderedProduct(
        productId: entry.value.productId,
        quantity: entry.value.quantity,
      );
    }).toList();
  }

  bool clearCart = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, orderState) {
      if (orderState is OrderAddedState && clearCart) {
        BlocProvider.of<CartCubit>(context).clear();
        clearCart = false;
      }
      return ElevatedButton(
        onPressed: BlocProvider.of<CartCubit>(context).totalAmount() <= 0
            ? null
            : () async {
                int userId = BlocProvider.of<AuthBloc>(context).authApi.userId;
                BlocProvider.of<OrderBloc>(context).add(
                  AddOrderEvent(
                    orderedProduct: convertCartMapToList(),
                    userId: userId,
                  ),
                );
                clearCart = true;
              },
        child: orderState is AddintOrderState
            ? const CircularProgressIndicator()
            : const Text('ORDER NOW'),
      );
    });
  }
}
