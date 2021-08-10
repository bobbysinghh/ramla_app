// To parse this JSON data, do
//
//     final orderHistoryModel = orderHistoryModelFromJson(jsonString);

import 'dart:convert';

OrderHistoryModel orderHistoryModelFromJson(String str) =>
    OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) =>
    json.encode(data.toJson());

class OrderHistoryModel {
  OrderHistoryModel({
    this.statuscode,
    this.data,
    this.message,
  });

  int statuscode;
  List<Datum> data;
  String message;

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
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
    this.transactionId,
    this.itemCount,
    this.orderAmount,
    this.shippingCharges,
    this.totalAmount,
    this.paidAmount,
    this.paymentStatus,
    this.orderStatus,
    this.orderdate,
    this.name,
    this.email,
    this.phone,
    this.building,
    this.community,
    this.area,
    this.emirates,
  });

  String id;
  String transactionId;
  String itemCount;
  String orderAmount;
  String shippingCharges;
  String totalAmount;
  String paidAmount;
  String paymentStatus;
  String orderStatus;
  String orderdate;
  String name;
  String email;
  String phone;
  String building;
  String community;
  String area;
  String emirates;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["ID"],
        transactionId: json["TransactionID"],
        itemCount: json["ItemCount"],
        orderAmount: json["OrderAmount"],
        shippingCharges: json["ShippingCharges"],
        totalAmount: json["TotalAmount"],
        paidAmount: json["PaidAmount"],
        paymentStatus: json["PaymentStatus"],
        orderStatus: json["OrderStatus"],
        orderdate: json["orderdate"],
        name: json["Name"],
        email: json["Email"],
        phone: json["Phone"],
        building: json["Building"],
        community: json["Community"],
        area: json["Area"],
        emirates: json["Emirates"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "TransactionID": transactionId,
        "ItemCount": itemCount,
        "OrderAmount": orderAmount,
        "ShippingCharges": shippingCharges,
        "TotalAmount": totalAmount,
        "PaidAmount": paidAmount,
        "PaymentStatus": paymentStatus,
        "OrderStatus": orderStatus,
        "orderdate": orderdate,
        "Name": name,
        "Email": email,
        "Phone": phone,
        "Building": building,
        "Community": community,
        "Area": area,
        "Emirates": emirates,
      };
}
