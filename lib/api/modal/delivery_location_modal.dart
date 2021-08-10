// To parse this JSON data, do
//
//     final deliveryLocationlModel = deliveryLocationlModelFromJson(jsonString);

import 'dart:convert';

DeliveryLocationlModel deliveryLocationlModelFromJson(String str) =>
    DeliveryLocationlModel.fromJson(json.decode(str));

String deliveryLocationlModelToJson(DeliveryLocationlModel data) =>
    json.encode(data.toJson());

class DeliveryLocationlModel {
  DeliveryLocationlModel({
    this.statuscode,
    this.data,
    this.message,
  });

  int statuscode;
  Data data;
  String message;

  factory DeliveryLocationlModel.fromJson(Map<String, dynamic> json) =>
      DeliveryLocationlModel(
        statuscode: json["statuscode"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statuscode": statuscode,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.list,
    this.propertyType,
  });

  List<ListElement> list;
  Map<String, String> propertyType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
        propertyType: Map.from(json["property_type"])
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "property_type": Map.from(propertyType)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class ListElement {
  ListElement({
    this.id,
    this.name,
    this.propertyType,
    this.community,
    this.emirate,
    this.area,
    this.deliverycenter,
  });

  String id;
  String name;
  String propertyType;
  String community;
  String emirate;
  String area;
  String deliverycenter;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["ID"],
        name: json["Name"],
        propertyType: json["PropertyType"],
        community: json["Community"],
        emirate: json["Emirate"],
        area: json["Area"],
        deliverycenter: json["Deliverycenter"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "PropertyType": propertyType,
        "Community": community,
        "Emirate": emirate,
        "Area": area,
        "Deliverycenter": deliverycenter,
      };
}
