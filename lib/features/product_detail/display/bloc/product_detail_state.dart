part of 'product_detail_bloc.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

final class ProductDetailInitial extends ProductDetailState {}

final class ProductDetailLoadInProgress extends ProductDetailState {}

final class ProductDetailLoadComplete extends ProductDetailState {
  final ProductDetailResponseModel productDetailData;

  const ProductDetailLoadComplete({required this.productDetailData});

  @override
  List<Object> get props => [productDetailData];
}

final class ProductDetailLoadFailure extends ProductDetailState {
  final String errorMessage;

  const ProductDetailLoadFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
