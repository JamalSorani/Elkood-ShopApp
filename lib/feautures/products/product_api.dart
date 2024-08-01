import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class ProductApi {
  final url = 'https://fakestoreapi.com/products';
  List<Product> products = [];
  Future<List<Product>> getAllProducts({String? query}) async {
    try {
      var response = await http
          .get(Uri.parse(url), headers: {'Content-type': 'application/json'});
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;
        products =
            jsonData.map((product) => Product.fromJson(product)).toList();
        if (query != null && query != '') {
          return products
              .where((product) =>
                  product.title.toLowerCase().startsWith(query.toLowerCase()))
              .toList();
        }

        return products;
      }

      throw ErrorDescription(response.body);
    } catch (error) {
      rethrow;
    }
  }

  Future<Product> fetchProductDetails(int id) async {
    return products.firstWhere((prod) => prod.id == id);
  }
}
