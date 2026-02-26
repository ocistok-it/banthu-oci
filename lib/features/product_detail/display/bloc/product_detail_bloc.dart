import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/result.dart';
import '../../data/models/product_detail_response_model.dart';
import '../../domain/usecases/product_detail_usecase.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailUsecase usecase;

  ProductDetailBloc({required this.usecase}) : super(ProductDetailInitial()) {
    on<ProductDetailRequested>(_onProductDetailRequested);
  }

  Future<void> _onProductDetailRequested(
    ProductDetailRequested event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoadInProgress());
    final result = await usecase.getProductDetail(
      store: event.store,
      productId: event.productId,
    );
    switch (result) {
      case Ok():
        {
          emit(ProductDetailLoadComplete(productDetailData: result.value));
        }
      case Error():
        {
          emit(ProductDetailLoadFailure(errorMessage: result.error.toString()));
        }
    }
  }
}
