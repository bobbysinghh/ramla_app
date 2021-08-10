import 'dart:convert';

import 'package:asset_app/api/config/config.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

enum SuggestLocationStatus { NotAdded, AddedIn, Adding }

class SuggestLocationProvider extends ChangeNotifier {
  SuggestLocationStatus _suggestLocationStatus = SuggestLocationStatus.NotAdded;
  SuggestLocationStatus get suggestLocationStatus => _suggestLocationStatus;

  set suggestLocationStatus(SuggestLocationStatus value) {
    _suggestLocationStatus = value;
  }

  Future addLocation(
    String name,
    String community,
    String areaid,
    // String zipcode,
    String emiratesid,
  ) async {
    final Map<String, dynamic> apiBodyData = {
      'name': name,
      'community': community,
      'areaid': areaid,
      // 'zipcode': zipcode,
      'emiratesid': emiratesid,
    };
    print(apiBodyData.toString());
    return await post(Uri.parse(Uri.encodeFull(AppUrl.addLocation)),
        body: apiBodyData,
        headers: {'Authorization': Config.fcmToken}).catchError(onError);
  }

  notify() {
    notifyListeners();
  }

  static onError(error) {
    print('the error is ${error.toString()}');
    return {'status': false, 'data': false, 'message': 'Unsuccessful Request'};
  }
}
