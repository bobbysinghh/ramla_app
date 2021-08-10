import 'package:asset_app/api/config/config.dart';
import 'package:asset_app/api/modal/user.dart';
import 'package:asset_app/api/utility/shared_preferences.dart';
import 'package:asset_app/components/profile_menu.dart';
import 'package:asset_app/order_history_screen.dart';
import 'package:asset_app/screens/login_screens/log_in.dart';
import 'package:asset_app/screens/user_profile.dart';
import 'package:flutter/material.dart';

class pBody extends StatelessWidget {
  // String User = "Jamil Ali";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 40, top: 20),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Hi, ${Config.name}",
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: "Montserrat"),
              ),
            ),
          ),

          Divider(),
          ProfileMenu(
            text: "My Orders",
            // icon: "assets/icons/iconmonstr-shopping-cart-3.svg",
            press: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderHistoryScreen()))
            },
          ),
          ProfileMenu(
            text: "My Reports",
            // icon: "assets/icons/iconmonstr-note-24.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "My Profile",
            // icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfile()));
            },
          ),
          ProfileMenu(
            text: "My Addresses",
            // icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "My Wallet",
            // icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Change Password",
            // icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            // icon: "assets/icons/Log out.svg",
            press: () {
              Config.name = "";
              Config.fcmToken = "";
              Config.userId = "";
              UserPreferences().removeUser();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          ),
          Divider(),

          //  ProfileMenu(press: () {}, text: "Terms & Conditions"),

          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Terms & Conditions",
                textDirection: TextDirection.ltr,
                style:
                    TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
              ),
            ),
          ),

          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Privacy Policy",
                textDirection: TextDirection.ltr,
                style:
                    TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Refund Policy",
                textDirection: TextDirection.ltr,
                style:
                    TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
