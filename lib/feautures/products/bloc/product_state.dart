part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class LoadingState extends ProductState {}

final class ErrorState extends ProductState {
  final String message;

  ErrorState({required this.message});
}

class LoadedState extends ProductState {
  final List<Product> products;

  LoadedState({required this.products});
}

class SearchProducteDoneState extends ProductState {
  final List<Product> products;

  SearchProducteDoneState({required this.products});
}

class FetchProductDetailState extends ProductState {
  final Product product;

  FetchProductDetailState({required this.product});
}
