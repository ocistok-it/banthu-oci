import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoriesResponseModel extends Equatable {
  final List<CategoryModel>? data;
  final String? message;
  final int? status;

  const CategoriesResponseModel({this.data, this.message, this.status});

  factory CategoriesResponseModel.fromRawJson(String str) =>
      CategoriesResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      CategoriesResponseModel(
        data:
            json["data"] == null
                ? []
                : List<CategoryModel>.from(
                  json["data"]!.map((x) => CategoryModel.fromJson(x)),
                ),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };

  @override
  List<Object?> get props => [data];
}

class CategoryModel extends Equatable {
  final List<SubCategoryModel>? child;
  final String? displayName;
  final int? id;
  final String? image;
  final bool? isBanned;
  final String? source;
  final String? tag;
  final bool? test;

  const CategoryModel({
    this.child,
    this.displayName,
    this.id,
    this.image,
    this.isBanned,
    this.source,
    this.tag,
    this.test,
  });

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    child:
        json["child"] == null
            ? []
            : List<SubCategoryModel>.from(
              json["child"]!.map((x) => SubCategoryModel.fromJson(x)),
            ),
    displayName: json["display_name"],
    id: json["id"],
    image: json["image"],
    isBanned: json["is_banned"],
    source: json["source"],
    tag: json["tag"],
    test: json["test"],
  );

  Map<String, dynamic> toJson() => {
    "child":
        child == null ? [] : List<dynamic>.from(child!.map((x) => x.toJson())),
    "display_name": displayName,
    "id": id,
    "image": image,
    "is_banned": isBanned,
    "source": source,
    "tag": tag,
    "test": test,
  };

  @override
  List<Object?> get props => [id];
}

class SubCategoryModel extends Equatable {
  final String? displayName;
  final int? id;
  final int? idmaincategory;
  final String? image;
  final bool? isBanned;
  final String? source;
  final int? subcategoryMaterialId;

  const SubCategoryModel({
    this.displayName,
    this.id,
    this.idmaincategory,
    this.image,
    this.isBanned,
    this.source,
    this.subcategoryMaterialId,
  });

  factory SubCategoryModel.fromRawJson(String str) =>
      SubCategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        displayName: json["display_name"],
        id: json["id"],
        idmaincategory: json["idmaincategory"],
        image: json["image"],
        isBanned: json["is_banned"],
        source: json["source"],
        subcategoryMaterialId: json["subcategory_material_id"],
      );

  Map<String, dynamic> toJson() => {
    "display_name": displayName,
    "id": id,
    "idmaincategory": idmaincategory,
    "image": image,
    "is_banned": isBanned,
    "source": source,
    "subcategory_material_id": subcategoryMaterialId,
  };

  @override
  List<Object?> get props => [id];
}
