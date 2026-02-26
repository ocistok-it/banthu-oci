import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/constants/app_assets.dart';
import '../../../../../core/utils/result.dart';
import '../../../data/models/categories_response_model.dart';
import '../../../domain/usecases/categories_usecase.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({required CategoriesUsecase usecase})
    : _usecase = usecase,
      super(CategoriesInitial()) {
    on<CategoriesRequested>(_onCategoriesLoaded);
  }

  final CategoriesUsecase _usecase;

  Future<void> _onCategoriesLoaded(
    CategoriesRequested event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoadInProgress());
    try {
      final result = await _usecase.getCategories();
      switch (result) {
        case Ok():
          {
            final CategoryModel recommendation = const CategoryModel(
              displayName: "Recommend",
              image: AppIcons.recommendationIcon,
              id: 42424242424242,
            );
            final categories = [recommendation, ...result.value.data!];
            emit(CategoriesLoadComplete(categories: categories));
          }
        case Error():
          {
            emit(CategoriesLoadFailure(errorMessage: result.error.toString()));
          }
      }
    } on Exception catch (e) {
      emit(CategoriesLoadFailure(errorMessage: e.toString()));
    }
  }
}
