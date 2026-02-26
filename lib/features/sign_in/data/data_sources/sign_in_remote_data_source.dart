import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/login_payload.dart';
import '../models/login_response_model.dart';

part 'sign_in_remote_data_source.g.dart';

@RestApi()
abstract class SignInRemoteDataSource {
  factory SignInRemoteDataSource(Dio dio, {String baseUrl}) =
      _SignInRemoteDataSource;

  @POST("auth/login/phone")
  Future<HttpResponse<LoginResponseModel>> signInUser<T>(
    @Body() SignInPayload payload,
  );
}
