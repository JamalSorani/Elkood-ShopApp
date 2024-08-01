import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState(items: {}));

  void addItem(int productId, double price, String title) {
    final currentItem = state.items[productId];
    if (currentItem != null) {
      // Update existing item
      emit(CartState(items: {
        ...state.items,
        productId: CartItem(
          productId: currentItem.productId,
          title: currentItem.title,
          price: currentItem.price,
          quantity: currentItem.quantity + 1,
        ),
      }));
    } else {
      // Add new item
      emit(CartState(items: {
        ...state.items,
        productId: CartItem(
          productId: productId,
          title: title,
          price: price,
          quantity: 1,
        ),
      }));
    }
  }

  void removeItem(productId) {
    final newItems = Map<int, CartItem>.from(state.items);
    newItems.remove(productId);
    emit(CartState(items: newItems));
  }

  void removeSingleItem(int productId) {
    final currentItem = state.items[productId];
    if (currentItem != null) {
      if (currentItem.quantity > 1) {
        emit(CartState(items: {
          ...state.items,
          productId: CartItem(
            productId: currentItem.productId,
            title: currentItem.title,
            price: currentItem.price,
            quantity: currentItem.quantity - 1,
          ),
        }));
      } else {
        removeItem(productId);
      }
    }
  }

  double totalAmount() {
    return state.items.values
        .fold(0, (total, item) => total + item.price * item.quantity);
  }

  int get itemCount => state.items.length;

  void clear() {
    emit(const CartState(items: {}));
  }
}
