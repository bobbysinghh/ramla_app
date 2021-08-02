// To parse this JSON data, do
//
//     final productsModalClass = productsModalClassFromJson(jsonString);

import 'dart:convert';

ProductsModalClass productsModalClassFromJson(String str) =>
    ProductsModalClass.fromJson(json.decode(str));

String productsModalClassToJson(ProductsModalClass data) =>
    json.encode(data.toJson());

class ProductsModalClass {
  ProductsModalClass({
    this.statuscode,
    this.data,
    this.message,
  });

  int statuscode;
  List<Datum> data;
  String message;

  factory ProductsModalClass.fromJson(Map<String, dynamic> json) =>
      ProductsModalClass(
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
    this.name,
    this.price,
    this.image,
    this.isEnable,
    this.isOffer,
    this.categoryNameEng,
    this.stock,
    this.unit,
  });

  String id;
  String name;
  String price;
  String image;
  String isEnable;
  String isOffer;
  String categoryNameEng;
  String stock;
  String unit;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["ID"],
        name: json["Name"],
        price: json["Price"],
        image: json["Image"],
        isEnable: json["IsEnable"],
        isOffer: json["IsOffer"],
        categoryNameEng: json["CategoryNameEng"],
        stock: json["Stock"],
        unit: json["Unit"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "Price": price,
        "Image": image,
        "IsEnable": isEnable,
        "IsOffer": isOffer,
        "CategoryNameEng": categoryNameEng,
        "Stock": stock,
        "Unit": unit,
      };
}
