import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    //@required
    this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextButton(
        //    padding: EdgeInsets.all(20),
        //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        //  color: Color(0xFFF5F6F9),
        onPressed: press,
        child: Row(
          children: [
            // Image.asset(
            //   icon,
            //   color: kPrimaryColor,
            //   width: 25,
            // ),
            SizedBox(width: 20),
            Expanded(
                child: Text(
              text,
              style:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
            )),
          ],
        ),
      ),
    );
  }
}
