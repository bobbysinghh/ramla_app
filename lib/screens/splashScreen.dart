import 'dart:async';
import 'package:asset_app/screens/login_screens/log_in.dart';
import 'package:asset_app/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => MainScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/Splash Screen@3x.png',
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                ),
                CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.orange.shade700),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
