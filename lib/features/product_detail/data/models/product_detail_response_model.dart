import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductDetailResponseModel extends Equatable {
  final List<ProductVariantModel>? variants;
  final List<ProductAttributeModel>? attribute;
  final int? catId;
  final String? category;
  final String? categoryCh;
  final String? createdAt;
  final double? currency;
  final String? desc;
  final List<ProductDescriptionModel>? descImage;
  final String? detailUrl;
  final List<ProductDiscountModel>? productDiscounts;
  final num? harga;
  final num? hargaIndo;
  final int? idRequest;
  final List<String>? itemImgs;
  final int? key;
  final String? message;
  final int? minOrder;
  final bool? nosku;
  final int? numIid;
  final String? picUrl;
  final String? range;
  final double? rating;
  final String? seller;
  final String? sellerid;
  final int? status;
  final String? title;
  final String? titleChina;
  final String? totalPenjualan;
  final String? totalProduct;
  final String? type;
  final List<String>? variant;
  final String? video;
  final bool? wishlist;

  const ProductDetailResponseModel({
    this.variants,
    this.attribute,
    this.catId,
    this.category,
    this.categoryCh,
    this.createdAt,
    this.currency,
    this.desc,
    this.descImage,
    this.detailUrl,
    this.productDiscounts,
    this.harga,
    this.hargaIndo,
    this.idRequest,
    this.itemImgs,
    this.key,
    this.message,
    this.minOrder,
    this.nosku,
    this.numIid,
    this.picUrl,
    this.range,
    this.rating,
    this.seller,
    this.sellerid,
    this.status,
    this.title,
    this.titleChina,
    this.totalPenjualan,
    this.totalProduct,
    this.type,
    this.variant,
    this.video,
    this.wishlist,
  });

  ProductDetailResponseModel copyWith({
    List<ProductVariantModel>? variants,
    List<ProductAttributeModel>? attribute,
    int? catId,
    String? category,
    String? categoryCh,
    String? createdAt,
    double? currency,
    String? desc,
    List<ProductDescriptionModel>? descImage,
    String? detailUrl,
    List<ProductDiscountModel>? productDiscounts,
    num? harga,
    num? hargaIndo,
    int? idRequest,
    List<String>? itemImgs,
    int? key,
    String? message,
    int? minOrder,
    bool? nosku,
    int? numIid,
    String? picUrl,
    String? range,
    double? rating,
    String? seller,
    String? sellerid,
    int? status,
    String? title,
    String? titleChina,
    String? totalPenjualan,
    String? totalProduct,
    String? type,
    List<String>? variant,
    String? video,
    bool? wishlist,
  }) => ProductDetailResponseModel(
    variants: variants ?? this.variants,
    attribute: attribute ?? this.attribute,
    catId: catId ?? this.catId,
    category: category ?? this.category,
    categoryCh: categoryCh ?? this.categoryCh,
    createdAt: createdAt ?? this.createdAt,
    currency: currency ?? this.currency,
    desc: desc ?? this.desc,
    descImage: descImage ?? this.descImage,
    detailUrl: detailUrl ?? this.detailUrl,
    productDiscounts: productDiscounts ?? this.productDiscounts,
    harga: harga ?? this.harga,
    hargaIndo: hargaIndo ?? this.hargaIndo,
    idRequest: idRequest ?? this.idRequest,
    itemImgs: itemImgs ?? this.itemImgs,
    key: key ?? this.key,
    message: message ?? this.message,
    minOrder: minOrder ?? this.minOrder,
    nosku: nosku ?? this.nosku,
    numIid: numIid ?? this.numIid,
    picUrl: picUrl ?? this.picUrl,
    range: range ?? this.range,
    rating: rating ?? this.rating,
    seller: seller ?? this.seller,
    sellerid: sellerid ?? this.sellerid,
    status: status ?? this.status,
    title: title ?? this.title,
    titleChina: titleChina ?? this.titleChina,
    totalPenjualan: totalPenjualan ?? this.totalPenjualan,
    totalProduct: totalProduct ?? this.totalProduct,
    type: type ?? this.type,
    variant: variant ?? this.variant,
    video: video ?? this.video,
    wishlist: wishlist ?? this.wishlist,
  );

  factory ProductDetailResponseModel.fromRawJson(String str) =>
      ProductDetailResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponseModel(
        variants:
            json["PropSku"] == null
                ? []
                : List<ProductVariantModel>.from(
                  json["PropSku"]!.map((x) => ProductVariantModel.fromJson(x)),
                ),
        attribute:
            json["attribute"] == null
                ? []
                : List<ProductAttributeModel>.from(
                  json["attribute"]!.map(
                    (x) => ProductAttributeModel.fromJson(x),
                  ),
                ),
        catId: json["cat_id"],
        category: json["category"],
        categoryCh: json["category_ch"],
        createdAt: json["created_at"],
        currency: json["currency"]?.toDouble(),
        desc: json["desc"],
        descImage:
            json["desc_image"] == null
                ? []
                : List<ProductDescriptionModel>.from(
                  json["desc_image"]!.map(
                    (x) => ProductDescriptionModel.fromJson(x),
                  ),
                ),
        detailUrl: json["detail_url"],
        productDiscounts:
            json["diskon"] == null
                ? []
                : List<ProductDiscountModel>.from(
                  json["diskon"]!.map((x) => ProductDiscountModel.fromJson(x)),
                ),
        harga: json["harga"],
        hargaIndo: json["harga_indo"],
        idRequest: json["id_request"],
        itemImgs:
            json["item_imgs"] == null
                ? []
                : List<String>.from(json["item_imgs"]!.map((x) => x)),
        key: json["key"],
        message: json["message"],
        minOrder: json["min_order"],
        nosku: json["nosku"],
        numIid: json["num_iid"],
        picUrl: json["pic_url"],
        range: json["range"],
        rating: json["rating"]?.toDouble(),
        seller: json["seller"],
        sellerid: json["sellerid"],
        status: json["status"],
        title: json["title"],
        titleChina: json["title_china"],
        totalPenjualan: json["total_penjualan"],
        totalProduct: json["total_product"],
        type: json["type"],
        variant:
            json["variant"] == null
                ? []
                : List<String>.from(json["variant"]!.map((x) => x)),
        video: json["video"],
        wishlist: json["wishlist"],
      );

  Map<String, dynamic> toJson() => {
    "PropSku":
        variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
    "attribute":
        attribute == null
            ? []
            : List<dynamic>.from(attribute!.map((x) => x.toJson())),
    "cat_id": catId,
    "category": category,
    "category_ch": categoryCh,
    "created_at": createdAt,
    "currency": currency,
    "desc": desc,
    "desc_image":
        descImage == null
            ? []
            : List<dynamic>.from(descImage!.map((x) => x.toJson())),
    "detail_url": detailUrl,
    "diskon":
        productDiscounts == null
            ? []
            : List<dynamic>.from(productDiscounts!.map((x) => x.toJson())),
    "harga": harga,
    "harga_indo": hargaIndo,
    "id_request": idRequest,
    "item_imgs":
        itemImgs == null ? [] : List<dynamic>.from(itemImgs!.map((x) => x)),
    "key": key,
    "message": message,
    "min_order": minOrder,
    "nosku": nosku,
    "num_iid": numIid,
    "pic_url": picUrl,
    "range": range,
    "rating": rating,
    "seller": seller,
    "sellerid": sellerid,
    "status": status,
    "title": title,
    "title_china": titleChina,
    "total_penjualan": totalPenjualan,
    "total_product": totalProduct,
    "type": type,
    "variant":
        variant == null ? [] : List<dynamic>.from(variant!.map((x) => x)),
    "video": video,
    "wishlist": wishlist,
  };

  @override
  List<Object?> get props => [catId, numIid];
}

class ProductAttributeModel extends Equatable {
  final String? attributeId;
  final String? attributeName;
  final String? attributeNameTrans;
  final String? value;
  final String? valueTrans;

  const ProductAttributeModel({
    this.attributeId,
    this.attributeName,
    this.attributeNameTrans,
    this.value,
    this.valueTrans,
  });

  ProductAttributeModel copyWith({
    String? attributeId,
    String? attributeName,
    String? attributeNameTrans,
    String? value,
    String? valueTrans,
  }) => ProductAttributeModel(
    attributeId: attributeId ?? this.attributeId,
    attributeName: attributeName ?? this.attributeName,
    attributeNameTrans: attributeNameTrans ?? this.attributeNameTrans,
    value: value ?? this.value,
    valueTrans: valueTrans ?? this.valueTrans,
  );

  factory ProductAttributeModel.fromRawJson(String str) =>
      ProductAttributeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) =>
      ProductAttributeModel(
        attributeId: json["attributeId"],
        attributeName: json["attributeName"],
        attributeNameTrans: json["attributeNameTrans"],
        value: json["value"],
        valueTrans: json["valueTrans"],
      );

  Map<String, dynamic> toJson() => {
    "attributeId": attributeId,
    "attributeName": attributeName,
    "attributeNameTrans": attributeNameTrans,
    "value": value,
    "valueTrans": valueTrans,
  };

  @override
  List<Object?> get props => [attributeId, attributeName];
}

class ProductDescriptionModel extends Equatable {
  final String? url;

  const ProductDescriptionModel({this.url});

  ProductDescriptionModel copyWith({String? url}) =>
      ProductDescriptionModel(url: url ?? this.url);

  factory ProductDescriptionModel.fromRawJson(String str) =>
      ProductDescriptionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDescriptionModel.fromJson(Map<String, dynamic> json) =>
      ProductDescriptionModel(url: json["url"]);

  Map<String, dynamic> toJson() => {"url": url};

  @override
  List<Object?> get props => [url];
}

class ProductDiscountModel extends Equatable {
  final num? diskon;
  final num? kuantiti;
  final num? value;

  const ProductDiscountModel({this.diskon, this.kuantiti, this.value});

  ProductDiscountModel copyWith({int? diskon, int? kuantiti, int? value}) =>
      ProductDiscountModel(
        diskon: diskon ?? this.diskon,
        kuantiti: kuantiti ?? this.kuantiti,
        value: value ?? this.value,
      );

  factory ProductDiscountModel.fromRawJson(String str) =>
      ProductDiscountModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDiscountModel.fromJson(Map<String, dynamic> json) =>
      ProductDiscountModel(
        diskon: json["diskon"],
        kuantiti: json["kuantiti"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
    "diskon": diskon,
    "kuantiti": kuantiti,
    "value": value,
  };

  @override
  List<Object?> get props => [kuantiti, value];
}

class ProductVariantModel extends Equatable {
  final List<ProductSubvariantModel>? subvariants;
  final String? properties;
  final int? total;
  final String? url;
  final String? value;
  final String? valueidn;

  const ProductVariantModel({
    this.subvariants,
    this.properties,
    this.total,
    this.url,
    this.value,
    this.valueidn,
  });

  ProductVariantModel copyWith({
    List<ProductSubvariantModel>? subvariants,
    String? properties,
    int? total,
    String? url,
    String? value,
    String? valueidn,
  }) => ProductVariantModel(
    subvariants: subvariants ?? this.subvariants,
    properties: properties ?? this.properties,
    total: total ?? this.total,
    url: url ?? this.url,
    value: value ?? this.value,
    valueidn: valueidn ?? this.valueidn,
  );

  factory ProductVariantModel.fromRawJson(String str) =>
      ProductVariantModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) =>
      ProductVariantModel(
        subvariants:
            json["children"] == null
                ? []
                : List<ProductSubvariantModel>.from(
                  json["children"]!.map(
                    (x) => ProductSubvariantModel.fromJson(x),
                  ),
                ),
        properties: json["properties"],
        total: json["total"],
        url: json["url"],
        value: json["value"],
        valueidn: json["valueidn"],
      );

  Map<String, dynamic> toJson() => {
    "children":
        subvariants == null
            ? []
            : List<dynamic>.from(subvariants!.map((x) => x.toJson())),
    "properties": properties,
    "total": total,
    "url": url,
    "value": value,
    "valueidn": valueidn,
  };

  @override
  List<Object?> get props => [value, valueidn];
}

class ProductSubvariantModel extends Equatable {
  final num? harga;
  final num? hargaIndo;
  final int? kelipatan;
  final int? minKuantiti;
  final String? properties;
  final int? qty;
  final bool? quoated;
  final int? skuId;
  final int? stock;
  final String? string;
  final String? variant;
  final String? variantIdn;

  const ProductSubvariantModel({
    this.harga,
    this.hargaIndo,
    this.kelipatan,
    this.minKuantiti,
    this.properties,
    this.qty,
    this.quoated,
    this.skuId,
    this.stock,
    this.string,
    this.variant,
    this.variantIdn,
  });

  ProductSubvariantModel copyWith({
    num? harga,
    num? hargaIndo,
    int? kelipatan,
    int? minKuantiti,
    String? properties,
    int? qty,
    bool? quoated,
    int? skuId,
    int? stock,
    String? string,
    String? variant,
    String? variantIdn,
  }) => ProductSubvariantModel(
    harga: harga ?? this.harga,
    hargaIndo: hargaIndo ?? this.hargaIndo,
    kelipatan: kelipatan ?? this.kelipatan,
    minKuantiti: minKuantiti ?? this.minKuantiti,
    properties: properties ?? this.properties,
    qty: qty ?? this.qty,
    quoated: quoated ?? this.quoated,
    skuId: skuId ?? this.skuId,
    stock: stock ?? this.stock,
    string: string ?? this.string,
    variant: variant ?? this.variant,
    variantIdn: variantIdn ?? this.variantIdn,
  );

  factory ProductSubvariantModel.fromRawJson(String str) =>
      ProductSubvariantModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductSubvariantModel.fromJson(Map<String, dynamic> json) =>
      ProductSubvariantModel(
        harga: json["harga"],
        hargaIndo: json["harga_indo"],
        kelipatan: json["kelipatan"],
        minKuantiti: json["min_kuantiti"],
        properties: json["properties"],
        qty: json["qty"],
        quoated: json["quoated"],
        skuId: json["sku_id"],
        stock: json["stock"],
        string: json["string"],
        variant: json["variant"],
        variantIdn: json["variantIdn"],
      );

  Map<String, dynamic> toJson() => {
    "harga": harga,
    "harga_indo": hargaIndo,
    "kelipatan": kelipatan,
    "min_kuantiti": minKuantiti,
    "properties": properties,
    "qty": qty,
    "quoated": quoated,
    "sku_id": skuId,
    "stock": stock,
    "string": string,
    "variant": variant,
    "variantIdn": variantIdn,
  };

  @override
  List<Object?> get props => [skuId, properties];
}
