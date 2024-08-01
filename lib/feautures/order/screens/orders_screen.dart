import 'package:elkood_shop_app/core/white_background.dart';
import 'package:elkood_shop_app/feautures/order/bloc/order_bloc.dart';
import 'package:elkood_shop_app/feautures/order/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Your Orders'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.navigate_before,
            color: Colors.white,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is ErrorState) {
            return ShowMessage(message: state.message);
          } else if (state is OrderDoneState) {
            if (state.orders.isNotEmpty) {
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (ctx, i) => OrderWidget(state.orders[i]),
              );
            } else {
              return const ShowMessage(message: 'There Are No Orders Yet');
            }
          }
          return const WhiteBackground(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
