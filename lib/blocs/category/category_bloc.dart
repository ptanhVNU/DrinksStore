import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/repos/category/category_repos.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  StreamSubscription? _categorySubcription;
  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryLoading()) {
    on<LoadCategories>(_onLoad);
    on<UpdateCategories>(_onUpdate);
  }

  void _onLoad(LoadCategories event, Emitter<CategoryState> emit) async {
    _categorySubcription?.cancel();
    _categorySubcription = _categoryRepository.getAllCategories().listen(
          (categories) => add(
            UpdateCategories(categories),
          ),
        );
  }

  void _onUpdate(UpdateCategories event, Emitter<CategoryState> emit) {
    emit(CategoryLoaded(categories: event.categories));
  }
}
