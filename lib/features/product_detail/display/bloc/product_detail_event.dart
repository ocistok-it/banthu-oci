part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

final class ProductDetailRequested extends ProductDetailEvent {
  final String store;
  final String productId;

  const ProductDetailRequested({required this.store, required this.productId});

  @override
  List<Object> get props => [store, productId];
}
