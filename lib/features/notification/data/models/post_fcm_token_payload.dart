import 'dart:convert';

import 'package:equatable/equatable.dart';

class PostFcmTokenPayload extends Equatable {
  final String email;
  final String token;
  final String deviceId;

  const PostFcmTokenPayload({
    required this.email,
    required this.token,
    required this.deviceId,
  });

  factory PostFcmTokenPayload.fromRawJson(String str) =>
      PostFcmTokenPayload.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostFcmTokenPayload.fromJson(Map<String, dynamic> json) =>
      PostFcmTokenPayload(
        email: json["email"],
        token: json["token"],
        deviceId: json["device_id"],
      );

  Map<String, dynamic> toJson() => {
    "email": email,
    "token": token,
    "device_id": deviceId,
  };

  @override
  List<Object?> get props => [email, token];
}
