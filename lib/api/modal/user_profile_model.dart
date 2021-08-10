// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  UserProfileModel({
    this.statuscode,
    this.data,
    this.message,
  });

  int statuscode;
  Data data;
  String message;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
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
    this.guid,
    this.name,
    this.email,
    this.phone,
    this.isEnable,
    this.createdDate,
    this.modifiedDate,
  });

  String guid;
  String name;
  String email;
  String phone;
  String isEnable;
  DateTime createdDate;
  dynamic modifiedDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        guid: json["Guid"],
        name: json["Name"],
        email: json["Email"],
        phone: json["Phone"],
        isEnable: json["IsEnable"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        modifiedDate: json["ModifiedDate"],
      );

  Map<String, dynamic> toJson() => {
        "Guid": guid,
        "Name": name,
        "Email": email,
        "Phone": phone,
        "IsEnable": isEnable,
        "CreatedDate": createdDate.toIso8601String(),
        "ModifiedDate": modifiedDate,
      };
}
