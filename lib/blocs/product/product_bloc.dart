import 'package:bloc/bloc.dart';
import 'package:fakestore_app/models/product.dart';
import 'package:fakestore_app/repositories/product_repository.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final result = await repository.getProducts();
        emit(ProductLoaded(result));
      } catch (err) {
        emit(ProductError('$err'));
      }
    });
  }
}
