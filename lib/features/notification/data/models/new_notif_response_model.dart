import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../core/utils/base_response_model.dart';

class NewNotifResponseModel extends BaseResponseModel with EquatableMixin {
  final NewNotifDataModel data;

  NewNotifResponseModel({required this.data, super.message, super.status});

  factory NewNotifResponseModel.fromRawJson(String str) =>
      NewNotifResponseModel.fromJson(json.decode(str));

  @override
  String toRawJson() => json.encode(toJson());

  factory NewNotifResponseModel.fromJson(Map<String, dynamic> json) =>
      NewNotifResponseModel(
        data: NewNotifDataModel.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  @override
  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "status": status,
  };

  @override
  List<Object?> get props => [data];
}

class NewNotifDataModel extends Equatable {
  final int total;

  const NewNotifDataModel({required this.total});

  factory NewNotifDataModel.fromRawJson(String str) =>
      NewNotifDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewNotifDataModel.fromJson(Map<String, dynamic> json) =>
      NewNotifDataModel(total: json["total"]);

  Map<String, dynamic> toJson() => {"total": total};

  @override
  List<Object?> get props => [total];
}
