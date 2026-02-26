import '../../../../core/utils/result.dart';
import '../../data/models/product_detail_response_model.dart';
import '../repositories/product_detail_repository.dart';

class ProductDetailUsecase {
  final ProductDetailRepository _repository;

  const ProductDetailUsecase({required ProductDetailRepository repository})
    : _repository = repository;

  Future<Result<ProductDetailResponseModel>> getProductDetail({
    required String store,
    required String productId,
  }) async =>
      await _repository.getProductDetail(store: store, productId: productId);
}
