import 'package:elkood_shop_app/core/show_snackbar.dart';
import 'package:elkood_shop_app/core/white_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/cubit/cart_cubit.dart';
import '../bloc/product_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as int;
    final width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, productState) {
        BlocProvider.of<ProductBloc>(context)
            .add(FetchProductDetailEvent(productId: productId));

        if (productState is FetchProductDetailState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: height * 0.9 - 70,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.06),
                        child: Image.network(
                          productState.product.imageUrl,
                          fit: BoxFit.fill,
                          height: width * 0.75,
                          width: width * 0.75,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 30),
                                Text(
                                  '${productState.product.title} :',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${productState.product.price} \$',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: height * 0.291,
                                  child: SingleChildScrollView(
                                    child: Text(
                                      productState.product.description,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: 70,
                child: TextButton.icon(
                  onPressed: () {
                    BlocProvider.of<CartCubit>(context).addItem(
                      productId,
                      productState.product.price,
                      productState.product.title,
                    );
                    showSnackBar(context, productId);
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 25,
                  ),
                  label: const Text(
                    'ADD TO CART',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const WhiteBackground(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
