import 'package:elkood_shop_app/core/app_drawer.dart';
import 'package:elkood_shop_app/core/routes_names.dart';

import 'package:elkood_shop_app/core/white_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/cubit/cart_cubit.dart';
import '../bloc/product_bloc.dart';
import '../product.dart';
import '../shimmer/products_screen_shimmer.dart';
import '../widgets/products_list.dart';
import '../widgets/search.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

List<Product> products = [];

class _ProductsScreenState extends State<ProductsScreen> {
  Future<void> _refresh(BuildContext context) async {
    products = [];
    BlocProvider.of<ProductBloc>(context).add(GetAllProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (d) async {
        return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Do you want to leave?',
                textAlign: TextAlign.center,
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                    'No',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text(
                    'Yes',
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Elkood ShopApp',
          ),
          actions: [
            IconButton(
              onPressed: () async {
                showSearch(context: context, delegate: ProductSearchDelegate());
              },
              icon: const Icon(Icons.search),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 10),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Badge(
                  label: Text(BlocProvider.of<CartCubit>(context, listen: true)
                      .itemCount
                      .toString()),
                  child: IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.cartScreen);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () => _refresh(context),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (products.isNotEmpty) {
                return ProductsList(
                  products: products,
                );
              } else if (state is LoadedState) {
                products = state.products;
                return ProductsList(
                  products: state.products,
                );
              } else if (state is ErrorState) {
                ShowMessage(message: state.message);
              } else {
                return const ProductsShimmerScreen();
              }
              return const ShowMessage(message: 'There are no products!');
            },
          ),
        ),
      ),
    );
  }
}
