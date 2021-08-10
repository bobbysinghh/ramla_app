// To parse this JSON data, do
//
//     final areaByEmirateslModel = areaByEmirateslModelFromJson(jsonString);

import 'dart:convert';

AreaByEmirateslModel areaByEmirateslModelFromJson(String str) =>
    AreaByEmirateslModel.fromJson(json.decode(str));

String areaByEmirateslModelToJson(AreaByEmirateslModel data) =>
    json.encode(data.toJson());

class AreaByEmirateslModel {
  AreaByEmirateslModel({
    this.statuscode,
    this.data,
    this.message,
  });

  int statuscode;
  List<Area> data;
  String message;

  factory AreaByEmirateslModel.fromJson(Map<String, dynamic> json) =>
      AreaByEmirateslModel(
        statuscode: json["statuscode"],
        data: List<Area>.from(json["data"].map((x) => Area.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statuscode": statuscode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Area {
  Area({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["ID"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
      };
}
