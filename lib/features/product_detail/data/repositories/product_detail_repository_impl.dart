import '../../../../core/utils/result.dart';
import '../../domain/repositories/product_detail_repository.dart';
import '../data_sources/product_detail_remote_data_source.dart';
import '../models/product_detail_response_model.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepository {
  final ProductDetailRemoteDataSource _productDetailRemoteDataSource;

  const ProductDetailRepositoryImpl({
    required ProductDetailRemoteDataSource productDetailRemoteDataSource,
  }) : _productDetailRemoteDataSource = productDetailRemoteDataSource;

  @override
  Future<Result<ProductDetailResponseModel>> getProductDetail({
    required String store,
    required String productId,
  }) async {
    try {
      final response = await _productDetailRemoteDataSource.fetchProduct(
        store: store,
        productId: productId,
      );
      switch (response) {
        case Ok():
          {
            return Result.ok(response.value);
          }
        case Error():
          {
            return Result.error(response.error);
          }
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
