import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial('general')) {
    on<SelectCategoryEvent>((event, emit) {
      emit(CategoryInitial(event.category));
    });
  }
}
