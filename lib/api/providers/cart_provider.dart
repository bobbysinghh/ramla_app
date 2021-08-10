import 'dart:convert';

import 'package:asset_app/api/config/config.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

enum CartStatus { NotAdded, AddedIn, Adding, Purchased }

class CartProvider extends ChangeNotifier {
  CartStatus _cartItemInStatus = CartStatus.NotAdded;
  CartStatus get cartItemInStatus => _cartItemInStatus;

  set cartItemInStatus(CartStatus value) {
    _cartItemInStatus = value;
  }

  Future addToCart(
      String id, String qty, String cuttingstyle_id, String queans) async {
    var deviceId = Config.deviceID;
    final Map<String, dynamic> productMappedData = {
      'id': id,
      'qty': qty,
      'cuttingstyle_id': cuttingstyle_id,
      'queans': queans,
    };
    print(productMappedData.toString());
    // List<Map> products = [productMappedData];
    final Map<String, dynamic> apiMappedData = {
      'products': productMappedData,
      'device_id': deviceId,
    };
    if (Config.fcmToken == "") {
      return await post(Uri.parse(AppUrl.addToCart),
              body: json.encode(apiMappedData))
          .catchError(onError);
    } else {
      return await post(Uri.parse(AppUrl.addToCart),
          body: json.encode(apiMappedData),
          headers: {'Authorization': Config.fcmToken}).catchError(onError);
    }
  }

  Future updateCart(String id, String qty, String cuttingstyle_id,
      String queans, String cartId) async {
    var deviceId = Config.deviceID;
    final Map<String, dynamic> productMappedData = {
      'id': id,
      'qty': qty,
      'cuttingstyle_id': cuttingstyle_id,
      'queans': queans,
      'cart_id': cartId,
    };
    print(productMappedData.toString());
    // List<Map> products = [productMappedData];
    final Map<String, dynamic> apiMappedData = {
      'products': productMappedData,
      'device_id': deviceId,
    };
    if (Config.fcmToken == "") {
      return await put(
        Uri.parse(AppUrl.updateCart),
        body: json.encode(apiMappedData),
      ).catchError(onError);
    } else {
      return await put(Uri.parse(AppUrl.updateCart),
          body: json.encode(apiMappedData),
          headers: {'Authorization': Config.fcmToken}).catchError(onError);
    }
  }

  notify() {
    notifyListeners();
  }

  static onError(error) {
    print('the error is ${error.toString()}');
    return {'status': false, 'data': false, 'message': 'Unsuccessful Request'};
  }
}
