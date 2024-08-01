import 'dart:math';

import 'package:elkood_shop_app/feautures/order/orders_api.dart';
import 'package:elkood_shop_app/feautures/products/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../products/product.dart';

class OrderWidget extends StatefulWidget {
  final OrderItem order;

  const OrderWidget(this.order, {super.key});

  @override
  OrderWidgetState createState() => OrderWidgetState();
}

class OrderWidgetState extends State<OrderWidget> {
  var _expanded = false;
  Map<int, Product> productsDetails = {};
  double calculateOrderTotal(List<Product> products) {
    double total = 0;
    for (final productInOrder in widget.order.products) {
      final product = products
          .firstWhere((product) => product.id == productInOrder.productId);
      productsDetails[productInOrder.productId] = product;
      total += product.price * productInOrder.quantity;
    }

    return total;
  }

  String title(String fullTitle) {
    var titleWords = fullTitle.split(' ');

    if (titleWords.length > 3) {
      return titleWords.sublist(0, 3).join(' ');
    }
    return fullTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is LoadedState) {
                  return Text('\$${calculateOrderTotal(state.products)}');
                } else {
                  return const SizedBox();
                }
              },
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(
                  () {
                    _expanded = !_expanded;
                  },
                );
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 25.0 + 10, 100),
              child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            title(productsDetails[prod.productId]!.title),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${prod.quantity}x \$${productsDetails[prod.productId]!.price}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
