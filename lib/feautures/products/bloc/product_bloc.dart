import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../product.dart';
import '../product_api.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductApi productApi;
  ProductBloc({required this.productApi}) : super(LoadingState()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetAllProductsEvent) {
        await Future.delayed(const Duration(seconds: 3));

        emit(LoadingState());
        try {
          final products = await productApi.getAllProducts(query: event.query);
          if (event.query != null) {
            emit(SearchProducteDoneState(products: products));
          } else {
            emit(LoadedState(products: products));
          }
        } catch (error) {
          print(error.toString());
          emit(ErrorState(message: error.toString()));
        }
      } else if (event is FetchProductDetailEvent) {
        try {
          final product = await productApi.fetchProductDetails(event.productId);
          emit(FetchProductDetailState(product: product));
        } catch (error) {
          print(error.toString());
          emit(ErrorState(message: error.toString()));
        }
      }
    });
  }
}
