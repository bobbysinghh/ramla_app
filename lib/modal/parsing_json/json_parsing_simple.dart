import 'package:asset_app/api/Networking/network.dart';
import 'package:asset_app/api/modal/categories_modal_class.dart';
import 'package:asset_app/api/utility/app_url.dart';

import 'package:asset_app/navigation/custom_bottom_nav_bar.dart';
import 'package:asset_app/widgets/tabview_page.dart';
import 'package:flutter/material.dart';

class JsonParsingSimple extends StatefulWidget {
  final CategoriesModalClass categoryData;
  final String categoryID;
  final int initialPosition;
  const JsonParsingSimple(
      {Key key, this.initialPosition, this.categoryID, this.categoryData})
      : super(key: key);

  @override
  _JsonParsingSimpleState createState() => _JsonParsingSimpleState();
}

class _JsonParsingSimpleState extends State<JsonParsingSimple> {
  // Future<dynamic> dataString;
  int _initPosition;

  @override
  void initState() {
    super.initState();
    _initPosition = widget.initialPosition;
  }

  Future<dynamic> getProductsDataByCategory(String categoryID) {
    print(AppUrl.productsByCategory + categoryID);
    Future<dynamic> dataString =
        Network(AppUrl.productsByCategory + 'categoryID').fetchData();
    dataString.then((value) {
      print(value);
    });
    return dataString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON parsing demo"),
      ),
      body: SafeArea(
          child: CustomTabView(
        initPosition: _initPosition,
        itemCount: widget.categoryData.data.length,
        tabBuilder: (context, index) {
          var data = widget.categoryData.data[index];
          return Tab(text: data.categoryNameEng);
        },
        pageBuilder: (context, index) {
          return TabViewPage(
            categoryID: widget.categoryData.data[index].id,
          );
        },
        onPositionChange: (index) {
          _initPosition = index;
        },
      )),
    );
  }
}
