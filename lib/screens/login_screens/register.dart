import 'dart:convert';

import 'package:asset_app/Common/custom_text_field.dart';
import 'package:asset_app/api/providers/auth_provider.dart';
import 'package:asset_app/api/utility/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double opacityPas = 0.2;
  double opacityCnfm = 0.2;
  bool obSecurePass = true;
  bool obSecureCnfm = true;
  bool _showFocusPass = false;
  bool _showFocusPassCnfm = false;
  final formKey = GlobalKey<FormState>();
  Duration get registerTime =>
      Duration(milliseconds: timeDilation.ceil() * 2250);
  String _name, _mobile, _email, _password, _confirmPassword;
  @override
  Widget build(BuildContext context) {
    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );
    AuthProvider auth = Provider.of<AuthProvider>(context);
    Future doRegister() async {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        print("name $_name");
        Response response = await auth.register(
            _name, _email, _mobile, _password, _confirmPassword);
        var data = jsonDecode(response.body);

        print("Data: ${data["statuscode"]}");
        print("Data: ${data}");
        //     then((response) {
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        //   // print(responseData.keys);
        if (data['statuscode'] == 1) {
          Future.delayed(registerTime).then((_) {
            Fluttertoast.showToast(
              msg: data['message'],
              timeInSecForIosWeb: 5,
            );
            auth.registeredInStatus = Status.Registered;
            auth.notify();
            Navigator.pop(context);
          });
        } else {
          Fluttertoast.showToast(
            msg: data['message'],
            timeInSecForIosWeb: 5,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Please complete the form properly",
          timeInSecForIosWeb: 5,
          // message: ,
        );
      }
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 251, 247, 1),
      body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Image.asset("assets/images/sign_in_image.png"),
                Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                            child: Text(
                              "Full Name",
                              style: TextStyle(fontSize: 15),
                            ),
                            padding: EdgeInsets.only(
                              left: 30,
                              bottom: 10,
                            )),
                        signUpTextFieldCommon(
                          validate: (value) =>
                              value.isEmpty ? "Please enter your name" : null,
                          top: 0,
                          onChanged: (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                          onSaved: (value) => _name = value,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                      "Email Id",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    padding: EdgeInsets.only(
                                      left: 30,
                                      top: 20,
                                      bottom: 10,
                                    )),
                                signUpTextFieldCommon(
                                  validate: validateEmail,
                                  width:
                                      (MediaQuery.of(context).size.width - 75) *
                                          0.5,
                                  right: 0,
                                  top: 0,
                                  onChanged: (value) {
                                    setState(() {
                                      _email = value;
                                    });
                                  },
                                  onSaved: (value) => _email = value,
                                  textInputType: TextInputType.emailAddress,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                      "Mobile",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      top: 20,
                                      bottom: 10,
                                    )),
                                signUpTextFieldCommon(
                                  validate: (value) => value.isEmpty
                                      ? "Please enter mobile number"
                                      : null,
                                  top: 0,
                                  left: 15,
                                  width:
                                      (MediaQuery.of(context).size.width - 75) *
                                          0.5,
                                  onChanged: (value) {
                                    setState(() {
                                      _mobile = value;
                                    });
                                  },
                                  onSaved: (value) => _mobile = value,
                                  textInputType: TextInputType.phone,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                signUpTextFieldCommon(
                                    validate: (value) => value.isEmpty
                                        ? "Please enter password"
                                        : null,
                                    top: 0,
                                    right: 0,
                                    width: (MediaQuery.of(context).size.width -
                                            75) *
                                        0.5,
                                    onChanged: (value) {
                                      setState(() {
                                        _password = value;
                                      });
                                    },
                                    onSaved: (value) => _password = value,
                                    suffixIcon: true,
                                    opacity: opacityPas,
                                    isObscure: obSecurePass,
                                    obSecureTap: () {
                                      setState(() {
                                        obSecurePass = !obSecurePass;
                                        if (!_showFocusPass) {
                                          opacityPas = 1;
                                          _showFocusPass = !_showFocusPass;
                                        } else if (_showFocusPass) {
                                          opacityPas = 0.2;
                                          _showFocusPass = !_showFocusPass;
                                        }
                                      });
                                    }),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                      "Confirm Password",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      top: 20,
                                      bottom: 10,
                                    )),
                                signUpTextFieldCommon(
                                    validate: (value) => value.isEmpty
                                        ? "Please enter password"
                                        : null,
                                    top: 0,
                                    left: 15,
                                    width: (MediaQuery.of(context).size.width -
                                            75) *
                                        0.5,
                                    onChanged: (value) {
                                      setState(() {
                                        _confirmPassword = value;
                                      });
                                    },
                                    onSaved: (value) =>
                                        _confirmPassword = value,
                                    suffixIcon: true,
                                    opacity: opacityCnfm,
                                    isObscure: obSecureCnfm,
                                    obSecureTap: () {
                                      setState(() {
                                        obSecureCnfm = !obSecureCnfm;
                                        if (!_showFocusPassCnfm) {
                                          opacityCnfm = 1;
                                          _showFocusPassCnfm =
                                              !_showFocusPassCnfm;
                                        } else if (_showFocusPassCnfm) {
                                          opacityCnfm = 0.2;
                                          _showFocusPassCnfm =
                                              !_showFocusPassCnfm;
                                        }
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 25,
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Already Existing User? Log In",
                              style: TextStyle(
                                color: Color.fromRGBO(245, 131, 33, 1),
                              ),
                            ),
                          ),
                        ),
                        auth.registeredInStatus == Status.Authenticating
                            ? loading
                            : customButton(
                                name: 'Register',
                                // callback: doRegister,
                                callback: () {
                                  doRegister();
                                  // if (formKey.currentState.validate()) {
                                  //   RegisterUser();
                                  // } else {
                                  //   print("unsuccesful");
                                  // }
                                }),
                      ],
                    ),
                  ),
                )
              ]))),
    );
  }
}
