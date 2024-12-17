part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

// product telah selesai di muat
class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);
}

// product gagal di muat
class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
