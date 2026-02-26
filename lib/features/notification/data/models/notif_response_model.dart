import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../core/utils/base_response_model.dart';

class NotificationResponseModel extends BaseResponseModel with EquatableMixin {
  final NotificationDataModel? data;

  NotificationResponseModel({this.data, super.message, super.status});

  factory NotificationResponseModel.fromRawJson(String str) =>
      NotificationResponseModel.fromJson(json.decode(str));

  @override
  String toRawJson() => json.encode(toJson());

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      NotificationResponseModel(
        data:
            json["data"] == null
                ? null
                : NotificationDataModel.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  @override
  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "status": status,
  };

  @override
  List<Object?> get props => [data];
}

class NotificationDataModel extends Equatable {
  final String? email;
  final List<NotificationModel>? notification;
  final int? total;

  const NotificationDataModel({this.email, this.notification, this.total});

  factory NotificationDataModel.fromRawJson(String str) =>
      NotificationDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) =>
      NotificationDataModel(
        email: json["email"],
        notification:
            json["notification"] == null
                ? []
                : List<NotificationModel>.from(
                  json["notification"]!.map(
                    (x) => NotificationModel.fromJson(x),
                  ),
                ),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
    "email": email,
    "notification":
        notification == null
            ? []
            : List<dynamic>.from(notification!.map((x) => x.toJson())),
    "total": total,
  };

  @override
  List<Object?> get props => [notification];
}

class NotificationModel extends Equatable {
  final String? date;
  final String? id;
  final bool? isNew;
  final NotifMessageModel? message;

  const NotificationModel({this.date, this.id, this.isNew, this.message});

  factory NotificationModel.fromRawJson(String str) =>
      NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        date: json["date"],
        id: json["id"],
        isNew: json["is_new"],
        message:
            json["message"] == null
                ? null
                : NotifMessageModel.fromJson(json["message"]),
      );

  NotificationModel copyWith({
    String? date,
    String? id,
    bool? isNew,
    NotifMessageModel? message,
  }) {
    return NotificationModel(
      date: date ?? this.date,
      id: id ?? this.id,
      isNew: isNew ?? this.isNew,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toJson() => {
    "date": date,
    "id": id,
    "is_new": isNew,
    "message": message?.toJson(),
  };

  @override
  List<Object?> get props => [id, date, message];
}

class NotifMessageModel extends Equatable {
  final String? content;
  final String? imageUrl;
  final NotifMessageMetaModel? meta;
  final String? title;

  const NotifMessageModel({this.content, this.imageUrl, this.meta, this.title});

  factory NotifMessageModel.fromRawJson(String str) =>
      NotifMessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotifMessageModel.fromJson(Map<String, dynamic> json) =>
      NotifMessageModel(
        content: json["content"],
        imageUrl: json["image_url"],
        meta:
            json["meta"] == null
                ? null
                : NotifMessageMetaModel.fromJson(json["meta"]),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
    "content": content,
    "image_url": imageUrl,
    "meta": meta?.toJson(),
    "title": title,
  };

  @override
  List<Object?> get props => [content, meta];
}

class NotifMessageMetaModel extends Equatable {
  final List<int>? content;

  const NotifMessageMetaModel({this.content});

  factory NotifMessageMetaModel.fromRawJson(String str) =>
      NotifMessageMetaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotifMessageMetaModel.fromJson(Map<String, dynamic> json) =>
      NotifMessageMetaModel(
        content:
            json["content"] == null
                ? []
                : List<int>.from(json["content"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "content":
        content == null ? [] : List<dynamic>.from(content!.map((x) => x)),
  };

  @override
  List<Object?> get props => [content];
}
