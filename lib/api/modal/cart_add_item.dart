class CartRequestModel {
  List<CartProducts> products;
  int deviceId;

  CartRequestModel({this.products, this.deviceId});

  CartRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<CartProducts>();
      json['products'].forEach((v) {
        products.add(new CartProducts.fromJson(v));
      });
    }
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['device_id'] = this.deviceId;
    return data;
  }
}

class CartProducts {
  String id;
  String qty;
  String extraQty;
  String cuttingstyleId;
  String queans;

  CartProducts(
      {this.id, this.qty, this.extraQty, this.cuttingstyleId, this.queans});

  CartProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    extraQty = json['extra_qty'];
    cuttingstyleId = json['cuttingstyle_id'];
    queans = json['queans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qty'] = this.qty;
    data['extra_qty'] = this.extraQty;
    data['cuttingstyle_id'] = this.cuttingstyleId;
    data['queans'] = this.queans;
    return data;
  }
}
