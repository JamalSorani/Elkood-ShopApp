import 'package:elkood_shop_app/core/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../feautures/auth/bloc/auth_bloc.dart';
import '../feautures/order/bloc/order_bloc.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.purple[50],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 5),
                borderRadius: BorderRadius.circular(150),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: Image.asset(
                  'assets/images/logo.jpg',
                ),
              ),
            ),
          ),
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is LoginDoneState) {
              return Text(
                state.userName,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                ),
              );
            }
            return const SizedBox();
          }),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Products'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.productsScreen);
            },
          ),
          const Divider(),
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            return ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Orders'),
              onTap: () {
                if (state is LoginDoneState) {
                  BlocProvider.of<OrderBloc>(context)
                      .add(FetchOrdersEvent(userId: state.userId));
                }
                Navigator.of(context).pushNamed(Routes.ordersScreen);
              },
            );
          }),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(Routes.authScreen);
              BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
            },
          ),
        ],
      ),
    );
  }
}
