import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class OrderedProduct {
  final int productId;
  final int quantity;

  OrderedProduct({required this.productId, required this.quantity});

  factory OrderedProduct.fromJson(Map<String, dynamic> json) {
    return OrderedProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}

class OrderItem {
  final int id;
  final DateTime dateTime;
  final List<OrderedProduct> products;

  OrderItem({
    required this.id,
    required this.dateTime,
    required this.products,
  });
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      dateTime: DateTime.parse(json['date']),
      products: (json['products'] as List<dynamic>)
          .map((productJson) => OrderedProduct.fromJson(productJson))
          .toList(),
    );
  }
}

class OrdersApi {
  final url = 'https://fakestoreapi.com/carts';

  Future<List<OrderItem>> fetchAndSetOrders(int userId) async {
    try {
      final response = await http.get(Uri.parse('$url/user/1'),
          headers: {'Content-type': 'application/json'});
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;

        var orders =
            jsonData.map((order) => OrderItem.fromJson(order)).toList();

        return orders;
      }
      throw ErrorDescription(response.body);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addOrder(
      List<OrderedProduct> orderedProducts, int userId) async {
    final timestamp = DateTime.now();
    orderedProducts
        .map((product) => {
              'productId': product.productId,
              'quantity': product.quantity,
            })
        .toList();
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-type': 'application/json'},
        body: json.encode({
          'userId': userId,
          'date': timestamp.toIso8601String(),
          'products': orderedProducts
              .map((product) => {
                    'productId': product.productId,
                    'quantity': product.quantity,
                  })
              .toList(),
        }),
      );
      if (response.statusCode == 200) {
        return;
      }
      throw ErrorDescription(response.body);
    } catch (error) {
      rethrow;
    }
  }
}
