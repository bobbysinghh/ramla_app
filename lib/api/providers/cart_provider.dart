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

  Future addToCart(String id, String qty, String extra_qty,
      String cuttingstyle_id, String queans) async {
    var deviceId = Config.deviceID;
    final Map<String, dynamic> productMappedData = {
      'id': id,
      'qty': qty,
      'extra_qty': extra_qty,
      'cuttingstyle_id': cuttingstyle_id,
      'queans': queans,
    };
    // List<Map> products = [productMappedData];
    final Map<String, dynamic> apiMappedData = {
      'products': productMappedData.toString(),
      'device_id': deviceId,
    };
    return await post(Uri.parse(Uri.encodeFull(AppUrl.addToCart)),
        body: apiMappedData,
        headers: {'Authorization': Config.fcmToken}).catchError(onError);
  }

  notify() {
    notifyListeners();
  }

  static onError(error) {
    print('the error is ${error.toString()}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
