// To parse this JSON data, do
//
//     final cartGetDetailsModel = cartGetDetailsModelFromJson(jsonString);

import 'dart:convert';

CartGetDetailsModel cartGetDetailsModelFromJson(String str) =>
    CartGetDetailsModel.fromJson(json.decode(str));

String cartGetDetailsModelToJson(CartGetDetailsModel data) =>
    json.encode(data.toJson());

class CartGetDetailsModel {
  CartGetDetailsModel({
    this.statuscode,
    this.data,
    this.message,
  });

  int statuscode;
  List<Datum> data;
  String message;

  factory CartGetDetailsModel.fromJson(Map<String, dynamic> json) =>
      CartGetDetailsModel(
        statuscode: json["statuscode"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statuscode": statuscode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.id,
    this.baseQty,
    this.extendedQty,
    this.weight,
    this.weightUnit,
    this.weightConv,
    this.weightConvUnit,
    this.cuttingstyleId,
    this.cuttingstylePrice,
    this.cuttingstyleName,
    this.queAns,
    this.price,
    this.name,
    this.productId,
    this.isEnable,
    this.image,
  });

  String id;
  String baseQty;
  String extendedQty;
  String weight;
  String weightUnit;
  String weightConv;
  String weightConvUnit;
  String cuttingstyleId;
  String cuttingstylePrice;
  String cuttingstyleName;
  String queAns;
  int price;
  String name;
  String productId;
  String isEnable;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["ID"],
        baseQty: json["BaseQty"],
        extendedQty: json["ExtendedQty"],
        weight: json["Weight"],
        weightUnit: json["WeightUnit"],
        weightConv: json["WeightConv"],
        weightConvUnit: json["WeightConvUnit"],
        cuttingstyleId: json["CuttingstyleID"],
        cuttingstylePrice: json["CuttingstylePrice"],
        cuttingstyleName: json["CuttingstyleName"],
        queAns: json["QueAns"],
        price: json["Price"],
        name: json["Name"],
        productId: json["ProductID"],
        isEnable: json["IsEnable"],
        image: json["Image"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "BaseQty": baseQty,
        "ExtendedQty": extendedQty,
        "Weight": weight,
        "WeightUnit": weightUnit,
        "WeightConv": weightConv,
        "WeightConvUnit": weightConvUnit,
        "CuttingstyleID": cuttingstyleId,
        "CuttingstylePrice": cuttingstylePrice,
        "CuttingstyleName": cuttingstyleName,
        "QueAns": queAns,
        "Price": price,
        "Name": name,
        "ProductID": productId,
        "IsEnable": isEnable,
        "Image": image,
      };
}
