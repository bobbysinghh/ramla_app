import 'package:asset_app/api/config/config.dart';
import 'package:asset_app/api/modal/cart_add_item.dart';
import 'package:asset_app/api/modal/cart_response_modal.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:dio/dio.dart';

class APIService {
  Future<CartResponseModel> addToCart(CartRequestModel model) async {
    // model.deviceId = int.parse(Setting.Secure.ANDROID_ID);
    CartResponseModel responseModel;
    try {
      var response = await Dio().post(
        AppUrl.baseUrl + AppUrl.addToCart,
        data: model.toJson(),
        options: new Options(
          headers: {'Authorization': Config.fcmToken},
        ),
      );
      if (response.statusCode == 200) {
        responseModel = CartResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.requestOptions);
      }
    }
    return responseModel;
  }
}
