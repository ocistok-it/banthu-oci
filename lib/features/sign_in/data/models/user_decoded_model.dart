import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserDecodedModel extends Equatable {
  final String? aud;
  final UserData? data;
  final String? email;
  final int? exp;
  final int? iat;
  final String? iss;
  final String? jti;
  final int? nbf;
  final List<String>? roles;
  final String? sub;
  final String? user;

  const UserDecodedModel({
    this.aud,
    this.data,
    this.email,
    this.exp,
    this.iat,
    this.iss,
    this.jti,
    this.nbf,
    this.roles,
    this.sub,
    this.user,
  });

  factory UserDecodedModel.fromRawJson(String str) =>
      UserDecodedModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDecodedModel.fromJson(Map<String, dynamic> json) =>
      UserDecodedModel(
        aud: json["aud"],
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
        email: json["email"],
        exp: json["exp"],
        iat: json["iat"],
        iss: json["iss"],
        jti: json["jti"],
        nbf: json["nbf"],
        roles:
            json["roles"] == null
                ? []
                : List<String>.from(json["roles"]!.map((x) => x)),
        sub: json["sub"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
    "aud": aud,
    "data": data?.toJson(),
    "email": email,
    "exp": exp,
    "iat": iat,
    "iss": iss,
    "jti": jti,
    "nbf": nbf,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "sub": sub,
    "user": user,
  };

  @override
  List<Object?> get props => [email, exp];
}

class UserData extends Equatable {
  final String? changeLanguage;
  final String? dateBirth;
  final String? email;
  final String? gender;
  final bool? isFirstTime;
  final bool? isVerified;
  final bool? ktpVerified;
  final String? level;
  final SalesInfo? salesInfo;
  final String? photo;
  final String? salesNumber;
  final String? telepon;
  final int? totalOrder;
  final String? userName;

  factory UserData.empty() => const UserData(email: null, telepon: null);

  const UserData({
    this.changeLanguage,
    this.dateBirth,
    this.email,
    this.gender,
    this.isFirstTime,
    this.isVerified,
    this.ktpVerified,
    this.level,
    this.salesInfo,
    this.photo,
    this.salesNumber,
    this.telepon,
    this.totalOrder,
    this.userName,
  });

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    changeLanguage: json["change_language"],
    dateBirth: json["date_birth"],
    email: json["email"],
    gender: json["gender"],
    isFirstTime: json["is_first_time"],
    isVerified: json["is_verified"],
    ktpVerified: json["ktp_verified"],
    level: json["level"],
    salesInfo:
        json["nama_sales"] == null
            ? null
            : SalesInfo.fromJson(json["nama_sales"]),
    photo: json["photo"],
    salesNumber: json["sales_number"],
    telepon: json["telepon"],
    totalOrder: json["total_order"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "change_language": changeLanguage,
    "date_birth": dateBirth,
    "email": email,
    "gender": gender,
    "is_first_time": isFirstTime,
    "is_verified": isVerified,
    "ktp_verified": ktpVerified,
    "level": level,
    "nama_sales": salesInfo?.toJson(),
    "photo": photo,
    "sales_number": salesNumber,
    "telepon": telepon,
    "total_order": totalOrder,
    "userName": userName,
  };

  @override
  List<Object?> get props => [email, telepon];
}

class SalesInfo extends Equatable {
  final String? nama;
  final String? telepon;

  const SalesInfo({this.nama, this.telepon});

  factory SalesInfo.fromRawJson(String str) =>
      SalesInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesInfo.fromJson(Map<String, dynamic> json) =>
      SalesInfo(nama: json["nama"], telepon: json["telepon"]);

  Map<String, dynamic> toJson() => {"nama": nama, "telepon": telepon};

  @override
  List<Object?> get props => [telepon];
}
