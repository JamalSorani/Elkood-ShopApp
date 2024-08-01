import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../feautures/cart/cubit/cart_cubit.dart';

void showSnackBar(BuildContext context, int productId) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0xFF262C66),
      content: const Text('Added to cart...'),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
          // textColor: color,
          label: 'undo',
          textColor: Colors.yellow,
          onPressed: () {
            BlocProvider.of<CartCubit>(context).removeSingleItem(productId);
            ScaffoldMessenger.of(context).clearSnackBars();
          }),
    ),
  );
}
