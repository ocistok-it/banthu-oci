import '../../../../core/utils/result.dart';
import '../../data/models/categories_response_model.dart';
import '../repositories/categories_repository.dart';

class CategoriesUsecase {
  final CategoriesRepository _repository;

  const CategoriesUsecase({required CategoriesRepository categoriesRepository})
    : _repository = categoriesRepository;

  Future<Result<CategoriesResponseModel>> getCategories() async =>
      await _repository.getCategories();

  Future<Result<CategoriesResponseModel>> getHomeCategories() async =>
      await _repository.getHomeCategories();
}
