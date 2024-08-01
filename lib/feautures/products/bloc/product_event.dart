part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class GetAllProductsEvent extends ProductEvent {
  final String? query;

  GetAllProductsEvent({this.query});
}

class FetchProductDetailEvent extends ProductEvent {
  final int productId;
  FetchProductDetailEvent({required this.productId});
}
