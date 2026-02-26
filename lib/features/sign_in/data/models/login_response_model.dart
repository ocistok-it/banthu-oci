import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  final String? accessToken;
  final int? exp;
  final String? refreshToken;
  final String? message;
  final String? otp;
  final int? status;
  final int? time;

  const LoginResponseModel({
    this.accessToken,
    this.exp,
    this.refreshToken,
    this.message,
    this.otp,
    this.status,
    this.time,
  });

  factory LoginResponseModel.fromRawJson(String str) =>
      LoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        accessToken: json["access_token"],
        exp: json["exp"],
        refreshToken: json["refresh_token"],
        message: json["message"],
        otp: json["otp"],
        status: json["status"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "exp": exp,
    "refresh_token": refreshToken,
    "message": message,
    "otp": otp,
    "status": status,
    "time": time,
  };

  @override
  List<Object?> get props => [accessToken, exp, refreshToken, status];
}
