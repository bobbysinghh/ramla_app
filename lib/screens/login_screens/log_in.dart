import 'dart:io';

import 'package:asset_app/Common/custom_text_field.dart';
import 'package:asset_app/api/config/config.dart';
import 'package:asset_app/api/modal/user.dart';
import 'package:asset_app/api/providers/auth_provider.dart';
import 'package:asset_app/api/providers/user_provider.dart';
import 'package:asset_app/api/utility/shared_preferences.dart';
import 'package:asset_app/api/utility/validator.dart';
import 'package:asset_app/screens/login_screens/register.dart';
import 'package:asset_app/screens/main_screen/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email, _password;
  bool _obscureText = true;
  double opacity = 0.2;
  bool _showFocus = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Login ... Please wait")
      ],
    );

    AuthProvider auth = Provider.of<AuthProvider>(context);
    var doLogin = () async {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      try {
        if (Platform.isAndroid) {
          var build = await deviceInfo.androidInfo;
          setState(() {});
        }
      } on Exception {}
      final form = formKey.currentState;

      if (form.validate()) {
        form.save();
        final Future<Map<String, dynamic>> respose =
            auth.login(_email, _password);
        respose.then((responseData) {
          if (responseData['statuscode'] == 1) {
            var userData = responseData['data'];
            User authUser = User.fromJson(userData);
            UserPreferences().saveUser(authUser).then((value) {
              auth.notify();
              User user = authUser;
              Provider.of<UserProvider>(context, listen: false).setUser(user);
              auth.loggedInStatus = Status.LoggedIn;
              Config.fcmToken = user.token;
              Config.userId = user.user_Guid;
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            });
            // auth.loggedInStatus = Status.LoggedIn;
          } else if (responseData['statuscode'] == 4) {
            Fluttertoast.showToast(
              msg: responseData['message'],
              timeInSecForIosWeb: 5,
            );
          } else {
            Fluttertoast.showToast(
              msg: "Invalid details",
              timeInSecForIosWeb: 5,
            );
          }
        });
      } else {
        Fluttertoast.showToast(
          msg: "Please complete the form properly",
          timeInSecForIosWeb: 5,
          // message: ,
        );
      }
    };
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 251, 247, 1),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Image.asset("assets/images/sign_in_image.png"),
              Container(
                  child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 70),
                    Container(
                        child: Text(
                          "Email ID",
                          style: TextStyle(fontSize: 15),
                        ),
                        padding: EdgeInsets.only(
                          left: 30,
                          bottom: 10,
                        )),
                    textFieldCommon(
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                        onSaved: (value) => _email = value,
                        validator: validateEmail,
                        hintText: '',
                        textInputType: TextInputType.emailAddress,
                        right: 30,
                        left: 30),
                    Container(
                        child: Text(
                          "Password",
                          style: TextStyle(fontSize: 15),
                        ),
                        padding: EdgeInsets.only(
                          left: 30,
                          top: 20,
                          bottom: 10,
                        )),
                    textFieldCommon(
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        onSaved: (value) => _password = value,
                        validator: (value) =>
                            value.isEmpty ? "Please enter Password" : null,
                        hintText: '',
                        textInputType: TextInputType.emailAddress,
                        right: 30,
                        left: 30,
                        // top: 30,
                        suffixIcon: true,
                        obscureText: _obscureText,
                        opacity: opacity,
                        obSecureTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                            if (!_showFocus) {
                              opacity = 1;
                              _showFocus = !_showFocus;
                            } else if (_showFocus) {
                              opacity = 0.4;
                              _showFocus = !_showFocus;
                            }
                          });
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 30, top: 15),
                          child: InkWell(
                            onTap: () async {
                              await _resetPassword(_email.trim());
                            },
                            child: Text(
                              "forgot Password?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    auth.loggedInStatus == Status.Authenticating
                        ? loading
                        : customButton(name: 'Login', callback: doLogin),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account,",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(245, 131, 33, 1),
                          ),
                        ),
                        Container(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(245, 131, 33, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  _resetPassword(String trim) {}
}
