import 'package:dio/dio.dart';

import '../../../../core/networks/networks.dart';
import '../../../../core/utils/result.dart';
import '../../domain/repositories/sign_in_repository.dart';
import '../data_sources/sign_in_remote_data_source.dart';
import '../models/login_payload.dart';
import '../models/login_response_model.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInRemoteDataSource _signInDataSource;

  const SignInRepositoryImpl({required SignInRemoteDataSource signInDataSource})
    : _signInDataSource = signInDataSource;

  @override
  Future<Result<LoginResponseModel>> signInUser({
    required SignInPayload payload,
  }) async {
    try {
      final httpResponse = await _signInDataSource.signInUser(payload);
      if (httpResponse.data.status != null) {
        return Result.error(
          NetworkException(
            httpResponse.data.message ?? "Unknown error",
            statusCode: httpResponse.data.status,
          ),
        );
      }
      return Result.ok(httpResponse.data);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
