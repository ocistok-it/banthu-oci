import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/utils/response_adapter.dart';
import '../../../../core/utils/result.dart';
import '../models/product_detail_response_model.dart';

part 'product_detail_remote_data_source.g.dart';

@RestApi(callAdapter: ResponseAdapter, parser: Parser.FlutterCompute)
abstract class ProductDetailRemoteDataSource {
  factory ProductDetailRemoteDataSource(Dio dio, {String baseUrl}) =
      _ProductDetailRemoteDataSource;

  @GET("get-china/{store}/{productId}")
  Future<Result<ProductDetailResponseModel>> fetchProduct({
    @Path("store") required String store,
    @Path("productId") required String productId,
  });
}

ProductDetailResponseModel deserializeProductDetailResponseModel(
  Map<String, dynamic> json,
) => ProductDetailResponseModel.fromJson(json);

Map<String, dynamic> serializeProductDetailResponseModel(
  ProductDetailResponseModel object,
) => object.toJson();
