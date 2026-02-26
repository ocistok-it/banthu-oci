import 'dart:convert';

class BaseResponseModel {
  final String? message;
  final int? status;

  BaseResponseModel({this.message, this.status});

  factory BaseResponseModel.fromRawJson(String str) =>
      BaseResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      BaseResponseModel(message: json["message"], status: json["status"]);

  Map<String, dynamic> toJson() => {"message": message, "status": status};
}
