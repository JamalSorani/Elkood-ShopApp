import 'package:elkood_shop_app/core/app_theme.dart';
import 'package:elkood_shop_app/core/routes_names.dart';
import 'package:elkood_shop_app/core/splash_screen.dart';
import 'package:elkood_shop_app/feautures/auth/screens_and_widgets/auth_screen.dart';
import 'package:elkood_shop_app/feautures/auth/bloc/auth_bloc.dart';
import 'package:elkood_shop_app/feautures/order/bloc/order_bloc.dart';
import 'package:elkood_shop_app/feautures/order/orders_api.dart';
import 'package:elkood_shop_app/feautures/products/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feautures/auth/auth_api.dart';
import 'feautures/cart/cubit/cart_cubit.dart';
import 'feautures/products/bloc/product_bloc.dart';
import 'feautures/products/product_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(authApi: AuthApi())..add(TryAutoLoginEvent()),
        ),
        BlocProvider(
          create: (context) =>
              ProductBloc(productApi: ProductApi())..add(GetAllProductsEvent()),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
          child: const MyApp(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(ordersApi: OrdersApi()),
          child: const MyApp(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is SplashState) {
              return const SplashScreen();
            }
            if (state is LoginDoneState) {
              return const ProductsScreen();
            } else {
              return const AuthScreen();
            }
          },
        ),
        routes: Routes.routes,
      ),
    );
  }
}
