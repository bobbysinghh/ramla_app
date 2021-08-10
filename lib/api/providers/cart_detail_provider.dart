// import 'package:asset_app/api/modal/cart_add_item.dart';
// import 'package:asset_app/api/service/api_services.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';

// class CartProvider extends ChangeNotifier {
//   APIService _apiService;
//   List<CartProducts> _cartProducts;
//   List<CartProducts> get cartProducts => _cartProducts;
//   double get totalRecords => _cartProducts.length.toDouble();

//   CartProvider() {
//     _apiService = new APIService();
//     _cartProducts = new List<CartProducts>();
//   }
//   void resetStreams() {
//     _apiService = new APIService();
//     _cartProducts = new List<CartProducts>();
//   }

//   void addToCart(CartProducts product, Function onCallBack) async {
//     CartRequestModel requestModel = new CartRequestModel();
//     requestModel.products = new List<CartProducts>();
//     if (_cartProducts == null) resetStreams();
//     _cartProducts.forEach((element) {
//       requestModel.products.add(new CartProducts(
//           id: element.id,
//           cuttingstyleId: element.cuttingstyleId,
//           extraQty: element.extraQty,
//           qty: element.qty,
//           queans: element.queans));
//     });
//     var isProductExist = requestModel.products
//         .firstWhere((prd) => prd.id == product.id, orElse: () => null);
//     if (isProductExist != null) {
//       requestModel.products.remove(isProductExist);
//     }
//     requestModel.products.add(product);

//     await _apiService.addToCart(requestModel).then((cartResponseModel) {
//       print(cartResponseModel.data);
//       // if (cartResponseModel.data == true) {
//       //   _cartProducts = [];
//       // }
//       onCallBack(cartResponseModel);
//       notifyListeners();
//     });
//   }
// }
