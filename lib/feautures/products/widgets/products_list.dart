import 'package:flutter/material.dart';
import '../product.dart';
import 'product_item.dart';

class ProductsList extends StatefulWidget {
  final List<Product> products;

  const ProductsList({super.key, required this.products});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 70.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFF1EFF1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: widget.products.length,
                itemBuilder: (ctx, i) => ProductItem(
                  product: widget.products[i],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
