import 'package:elkood_shop_app/feautures/order/screens/orders_screen.dart';
import 'package:flutter/material.dart';

import '../feautures/auth/screens_and_widgets/auth_screen.dart';
import '../feautures/cart/screens/cart_screen.dart';
import '../feautures/products/screens/product_detail_screen.dart';
import '../feautures/products/screens/products_screen.dart';

class Routes {
  static String productsScreen = '/products_screen';
  static String productDetailsScreen = '/products_details_screen';
  static String cartScreen = '/cart_screen';
  static String ordersScreen = '/orders_screen';
  static String authScreen = '/auth_screen';
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    Routes.productsScreen: (context) => const ProductsScreen(),
    Routes.productDetailsScreen: (context) => const ProductDetailScreen(),
    Routes.cartScreen: (context) => const CartScreen(),
    Routes.authScreen: (context) => const AuthScreen(),
    Routes.ordersScreen: (context) => const OrdersScreen(),
  };
}
