// To parse this JSON data, do
//
//     final categoriesModalClass = categoriesModalClassFromJson(jsonString);

import 'dart:convert';

CategoriesModalClass categoriesModalClassFromJson(String str) =>
    CategoriesModalClass.fromJson(json.decode(str));

String categoriesModalClassToJson(CategoriesModalClass data) =>
    json.encode(data.toJson());

class CategoriesModalClass {
  CategoriesModalClass({
    this.statuscode,
    this.data,
    this.message,
  });

  int statuscode;
  List<Datum> data;
  String message;

  factory CategoriesModalClass.fromJson(Map<String, dynamic> json) =>
      CategoriesModalClass(
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
    this.categoryNameEng,
    this.arabicName,
    this.image,
  });

  String id;
  String categoryNameEng;
  String arabicName;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["ID"],
        categoryNameEng: json["CategoryNameEng"],
        arabicName: json["ArabicName"],
        image: json["Image"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CategoryNameEng": categoryNameEng,
        "ArabicName": arabicName,
        "Image": image,
      };
}
