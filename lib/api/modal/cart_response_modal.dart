class CartResponseModel {
  int statuscode;
  bool data;
  String message;

  CartResponseModel({this.statuscode, this.data, this.message});

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}
