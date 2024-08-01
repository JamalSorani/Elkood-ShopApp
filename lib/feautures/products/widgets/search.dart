import 'package:elkood_shop_app/core/app_theme.dart';
import 'package:elkood_shop_app/core/routes_names.dart';
import '../bloc/product_bloc.dart';
import '../product.dart';
import 'package:elkood_shop_app/core/white_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'products_list.dart';

class ProductSearchDelegate extends SearchDelegate<Product?> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        hintColor: Colors.white,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        inputDecorationTheme:
            const InputDecorationTheme(border: InputBorder.none));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        query = '';
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.navigate_before,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<ProductBloc>(context)
        .add(GetAllProductsEvent(query: query.toLowerCase()));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routes: Routes.routes,
      home: Scaffold(
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is SearchProducteDoneState) {
              if (state.products.isNotEmpty) {
                return ProductsList(
                  products: state.products,
                );
              } else {
                const ShowMessage(message: 'there is no search result!');
              }
            } else if (state is ErrorState) {
              ShowMessage(message: state.message);
            }
            return const WhiteBackground(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const WhiteBackground(
      child: ShowMessage(message: 'Search For Products...'),
    );
  }
}
