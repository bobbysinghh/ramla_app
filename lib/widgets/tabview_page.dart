import 'package:asset_app/api/Networking/network.dart';
import 'package:asset_app/api/modal/products_modal_class.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:asset_app/screens/category_list_items.dart';
import 'package:flutter/material.dart';

class TabViewPage extends StatefulWidget {
  final String categoryID;
  const TabViewPage({Key key, this.categoryID}) : super(key: key);

  @override
  _TabViewPageState createState() => _TabViewPageState();
}

class _TabViewPageState extends State<TabViewPage> {
  Future<dynamic> dataString;
  String categoryId;
  @override
  void initState() {
    super.initState();
    categoryId = widget.categoryID;
    dataString = Network(AppUrl.productsByCategory + categoryId).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataString,
      builder: (builder, snapshot) {
        if (snapshot.hasData) {
          ProductsModalClass productsModal =
              productsModalClassFromJson(snapshot.data);
          return CategoryListItems(productList: productsModal.data);
        }
        return Container(child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
