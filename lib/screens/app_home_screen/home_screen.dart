import 'package:asset_app/Common/custom_text_field.dart';
import 'package:asset_app/components/drawer.dart';
import 'package:asset_app/constants.dart';
import 'package:asset_app/screens/app_home_screen/banner_slider.dart';
import 'package:asset_app/screens/app_home_screen/home_screen_category.dart';
import 'package:asset_app/screens/app_home_screen/hot_deals.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = new TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 251, 247, 1),
      drawer: Drawer(
        child: pBody(),
      ),
      appBar: searchAppBar(
          backgroundColor: kPrimaryColor, controller: _searchController),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(top: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              BannerSlider(),
              SizedBox(
                height: 10,
              ),
              HomeScreenCategories(),
              SizedBox(
                height: 15,
              ),
              HotDeals()
            ])),
      )),
    );
  }
}
