import 'package:elkood_shop_app/core/routes_names.dart';
import 'package:elkood_shop_app/core/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/cubit/cart_cubit.dart';
import '../product.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    var titleWords = product.title.split(' ');

    String title = product.title;
    if (titleWords.length > 5) {
      setState(() {
        title = titleWords.sublist(0, 5).join(' ');
      });
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.productDetailsScreen,
          arguments: product.id,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        height: 190.0,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 166.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(10, 20),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 45,
              left: 15,
              child: SizedBox(
                height: 120,
                width: 120,
                child: FadeInImage(
                  placeholder: const AssetImage('assets/images/holder.png'),
                  image: NetworkImage(
                    product.imageUrl,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: SizedBox(
                height: 136.0,
                width: MediaQuery.of(context).size.width - 170,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 25,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF262C66),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Text(
                              ' \$ ${product.price}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_cart,
                            ),
                            onPressed: () {
                              BlocProvider.of<CartCubit>(context).addItem(
                                  product.id, product.price, product.title);

                              showSnackBar(context, product.id);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
