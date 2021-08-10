import 'dart:convert';

import 'package:asset_app/Common/custom_text_field.dart';
import 'package:asset_app/api/Networking/network.dart';
import 'package:asset_app/api/modal/user_profile_model.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  Future<dynamic> dataString;
  @override
  void initState() {
    super.initState();
    dataString = NetworkWithHeaders(AppUrl.getUserProfile).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 251, 247, 1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              "My Profile",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: dataString,
          builder: (builder, snapshot) {
            if (snapshot.hasData) {
              var decodeData = json.decode(snapshot.data);
              if (decodeData["statuscode"] == 1) {
                UserProfileModel userProfileDetails =
                    userProfileModelFromJson(snapshot.data);
                _nameController.text = userProfileDetails.data.name;
                _emailController.text = userProfileDetails.data.email;
                _mobileNumberController.text = userProfileDetails.data.phone;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              top: 0, controller: _nameController),
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
                                    width: (MediaQuery.of(context).size.width -
                                            75) *
                                        0.5,
                                    right: 0,
                                    top: 0,
                                    controller: _emailController,
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
                                    top: 0,
                                    left: 15,
                                    width: (MediaQuery.of(context).size.width -
                                            75) *
                                        0.5,
                                    controller: _mobileNumberController,
                                    textInputType: TextInputType.phone,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    customButton(name: "Update Profile", callback: () {})
                  ],
                );
              } else {
                return Container(
                    child: Center(
                  child: Text(decodeData["message"]),
                ));
              }
            }
            return CircularProgressIndicator();
          },
        ));
  }
}
