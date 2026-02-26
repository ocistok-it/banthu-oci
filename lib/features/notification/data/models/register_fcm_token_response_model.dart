import 'dart:convert';

import '../../../../core/utils/base_response_model.dart';

class RegisterFcmTokenResponseModel extends BaseResponseModel {
  RegisterFcmTokenResponseModel({
    required super.message,
    required super.status,
  });

  factory RegisterFcmTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterFcmTokenResponseModel(
        message: json["message"],
        status: json["status"],
      );

  factory RegisterFcmTokenResponseModel.fromRawJson(String str) =>
      RegisterFcmTokenResponseModel.fromJson(json.decode(str));

  @override
  Map<String, dynamic> toJson() => {"message": message, "status": status};
}
