import 'package:bloc/bloc.dart';
import 'package:fakestore_app/repositories/category_repository.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(CategoryInitial()) {
    on<FetchCategories>((event, emit) async {
      emit(CategoryLoading());

      try {
        final response = await _categoryRepository.getCategories();
        emit(CategoryLoaded(categories: response));
      } catch (err) {
        emit(CategoryError(message: '$err'));
      }
    });
  }
}
