import '../../../../core/utils/result.dart';
import '../../domain/repositories/categories_repository.dart';
import '../data_sources/categories_remote_data_source.dart';
import '../models/categories_response_model.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource _categoriesRemoteDataSource;

  const CategoriesRepositoryImpl({
    required CategoriesRemoteDataSource categoriesRemoteDataSource,
  }) : _categoriesRemoteDataSource = categoriesRemoteDataSource;

  @override
  Future<Result<CategoriesResponseModel>> getCategories() async {
    try {
      final response = await _categoriesRemoteDataSource.fetchCategories();
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

  @override
  Future<Result<CategoriesResponseModel>> getHomeCategories() async {
    try {
      final response = await _categoriesRemoteDataSource.fetchHomeCategories();
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
