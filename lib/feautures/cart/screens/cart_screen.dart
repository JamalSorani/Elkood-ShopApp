import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_item.dart';
import '../widgets/order_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Your Cart'),
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
      body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
        return Column(
          children: [
            Card(
              color: Colors.purple[100],
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    Chip(
                      label: Text(
                        '\$${state.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: color,
                    ),
                    OrderButton(
                      cart: state.items,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (ctx, i) {
                  return CartWidget(
                    state.items.values.toList()[i].productId,
                    state.items.keys.toList()[i],
                    state.items.values.toList()[i].price,
                    state.items.values.toList()[i].quantity,
                    state.items.values.toList()[i].title,
                  );
                },
              ),
            )
          ],
        );
      }),
    );
  }
}
