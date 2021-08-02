// To parse this JSON data, do
//
//     final bannersModal = bannersModalFromJson(jsonString);

import 'dart:convert';

BannersModal bannersModalFromJson(String str) =>
    BannersModal.fromJson(json.decode(str));

String bannersModalToJson(BannersModal data) => json.encode(data.toJson());

class BannersModal {
  BannersModal({
    this.statuscode,
    this.data,
    this.message,
  });

  int statuscode;
  var data;
  String message;

  factory BannersModal.fromJson(Map<String, dynamic> json) => BannersModal(
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
    this.image,
  });

  String id;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["ID"],
        image: json["Image"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Image": image,
      };
}
