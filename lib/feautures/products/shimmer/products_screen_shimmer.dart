import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductsShimmerScreen extends StatelessWidget {
  const ProductsShimmerScreen({super.key});

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
                  itemCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, i) => const ProductShimmerItem()),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductShimmerItem extends StatelessWidget {
  const ProductShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 190.0,
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 166.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
