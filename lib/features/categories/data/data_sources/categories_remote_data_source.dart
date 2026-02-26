import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/utils/response_adapter.dart';
import '../../../../core/utils/result.dart';
import '../models/categories_response_model.dart';

part 'categories_remote_data_source.g.dart';

@RestApi(callAdapter: ResponseAdapter, parser: Parser.FlutterCompute)
abstract class CategoriesRemoteDataSource {
  factory CategoriesRemoteDataSource(Dio dio, {String baseUrl}) =
      _CategoriesRemoteDataSource;

  @GET("oci/cms/categories/home")
  Future<Result<CategoriesResponseModel>> fetchHomeCategories();

  @GET("oci/cms/categories")
  Future<Result<CategoriesResponseModel>> fetchCategories();
}

CategoriesResponseModel deserializeCategoriesResponseModel(
  Map<String, dynamic> json,
) => CategoriesResponseModel.fromJson(json);

Map<String, dynamic> serializeCategoriesResponseModel(
  CategoriesResponseModel object,
) => object.toJson();
