import '../../../../core/utils/result.dart';
import '../../data/models/categories_response_model.dart';

abstract class CategoriesRepository {
  Future<Result<CategoriesResponseModel>> getCategories();

  Future<Result<CategoriesResponseModel>> getHomeCategories();
}
