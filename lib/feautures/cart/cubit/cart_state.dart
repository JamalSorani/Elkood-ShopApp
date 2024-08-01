part of 'cart_cubit.dart';

class CartItem {
  final int productId;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

@immutable
class CartState {
  final Map<int, CartItem> items;

  const CartState({required this.items});

  double get totalAmount {
    return items.values
        .fold(0, (total, item) => total + item.price * item.quantity);
  }
}
