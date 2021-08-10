// To parse this JSON data, do
//
//     final emirateslModel = emirateslModelFromJson(jsonString);

import 'dart:convert';

EmirateslModel emirateslModelFromJson(String str) =>
    EmirateslModel.fromJson(json.decode(str));

String emirateslModelToJson(EmirateslModel data) => json.encode(data.toJson());

class EmirateslModel {
  EmirateslModel({
    this.statuscode,
    this.data,
    this.message,
  });

  var statuscode;
  List<Datum> data;
  String message;

  factory EmirateslModel.fromJson(Map<String, dynamic> json) => EmirateslModel(
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
  });

  String id;
  String name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["ID"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
      };
}
