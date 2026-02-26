import 'dart:convert';

import 'package:equatable/equatable.dart';

class SignInPayload extends Equatable {
  final String? email;
  final String? password;

  const SignInPayload({this.email, this.password});

  factory SignInPayload.fromRawJson(String str) =>
      SignInPayload.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignInPayload.fromJson(Map<String, dynamic> json) =>
      SignInPayload(email: json["email"], password: json["password"]);

  Map<String, dynamic> toJson() => {"email": email, "password": password};

  @override
  List<Object?> get props => [email, password];
}
