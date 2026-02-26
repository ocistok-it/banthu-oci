import '../../../../core/utils/result.dart';
import '../../data/models/product_detail_response_model.dart';

abstract class ProductDetailRepository {
  Future<Result<ProductDetailResponseModel>> getProductDetail({
    required String store,
    required String productId,
  });
}
