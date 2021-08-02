import 'dart:async';
import 'dart:convert';
import 'package:asset_app/api/modal/user.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:asset_app/api/utility/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _registeredInStatus;

  set registeredInStatus(Status value) {
    _registeredInStatus = value;
  }

  Future register(
    String name,
    String email,
    String mobileNumber,
    String password,
    String confirmPassword,
  ) async {
    final Map<String, dynamic> apiBodyData = {
      'name': name,
      'email': email,
      'phone': mobileNumber,
      'password': password,
      'cpassword': confirmPassword,
    };
    print(apiBodyData.toString());
    return await post(
      Uri.parse(Uri.encodeFull(AppUrl.register)),
      body: apiBodyData,
    ).catchError(onError);
  }

  notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(
      Uri.parse(Uri.encodeFull(AppUrl.login)),
      body: loginData,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // var userData = responseData['data'];
      // User authUser = User.fromJson(userData);
      // UserPreferences().saveUser(authUser);
      // _loggedInStatus = Status.LoggedIn;
      // notifyListeners();

      return responseData;
    } else {
      print(response.statusCode);
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'statuscode': 100,
        'data': null,
        'message': json.decode(response.body)['error']
      };
    }

    return result;
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
