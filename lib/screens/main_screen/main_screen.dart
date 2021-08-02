import 'package:asset_app/api/config/config.dart';
import 'package:asset_app/navigation/bottom_navbar.dart';
import 'package:asset_app/screens/app_home_screen/home_screen.dart';
import 'package:asset_app/screens/category_view.dart';
import 'package:asset_app/screens/checkout_screen.dart';
import 'package:asset_app/screens/offers_screen.dart';
import 'package:asset_app/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:client_information/client_information.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final tabs = [
    HomeScreen(),
    CategoriesDisplay(),
    OffersScreen(),
    CheckoutScreen(),
    UserProfile(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getClientInformation();
  }

  Future<void> _getClientInformation() async {
    ClientInformation info;
    try {
      info = await ClientInformation.fetch();
    } on PlatformException {
      print('Failed to get client information');
    }
    if (!mounted) return;
    print(info.deviceId);
    Config.deviceID = info.deviceId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        valueSetter: (value) => setState(() {
          _selectedIndex = value;
        }),
      ),
    );
  }
}
