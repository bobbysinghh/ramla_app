// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) =>
    json.encode(data.toJson());

class OrderDetailModel {
  OrderDetailModel({
    this.statuscode,
    this.data,
    this.message,
  });

  int statuscode;
  Data data;
  String message;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
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
    this.items,
  });

  String guid;
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
  List<Item> items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        guid: json["Guid"],
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
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Guid": guid,
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
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.id,
    this.productName,
    this.weight,
    this.unit,
    this.cuttingstyleName,
    this.cuttingStylePrice,
    this.amount,
    this.totalAmount,
    this.queAns,
  });

  String id;
  String productName;
  String weight;
  String unit;
  String cuttingstyleName;
  String cuttingStylePrice;
  String amount;
  String totalAmount;
  String queAns;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["ID"],
        productName: json["ProductName"],
        weight: json["Weight"],
        unit: json["Unit"],
        cuttingstyleName: json["CuttingstyleName"],
        cuttingStylePrice: json["CuttingStylePrice"],
        amount: json["Amount"],
        totalAmount: json["TotalAmount"],
        queAns: json["QueAns"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "ProductName": productName,
        "Weight": weight,
        "Unit": unit,
        "CuttingstyleName": cuttingstyleName,
        "CuttingStylePrice": cuttingStylePrice,
        "Amount": amount,
        "TotalAmount": totalAmount,
        "QueAns": queAns,
      };
}
