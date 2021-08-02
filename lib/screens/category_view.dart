import 'package:asset_app/Common/custom_text_field.dart';
import 'package:asset_app/api/Networking/network.dart';
import 'package:asset_app/api/modal/categories_modal_class.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:asset_app/components/drawer.dart';
import 'package:asset_app/constants.dart';
import 'package:asset_app/modal/parsing_json/json_parsing_simple.dart';
import 'package:flutter/material.dart';

class CategoriesDisplay extends StatefulWidget {
  const CategoriesDisplay({Key key}) : super(key: key);

  @override
  State<CategoriesDisplay> createState() => _CategoriesDisplayState();
}

class _CategoriesDisplayState extends State<CategoriesDisplay> {
  Future<dynamic> dataString;
  @override
  void initState() {
    super.initState();
    dataString = Network(AppUrl.allCategories).fetchData();
  }

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
          child: FutureBuilder(
              future: dataString,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  CategoriesModalClass categoriesmodal =
                      categoriesModalClassFromJson(snapshot.data);
                  return Container(
                    padding: EdgeInsets.all(15.0),
                    child: GridView.builder(
                      itemCount: categoriesmodal.data.length,
                      itemBuilder: (context, index) {
                        var category = categoriesmodal.data[index];
                        return _getCardByTitle(
                            categoriesData: categoriesmodal,
                            categoryID: category.id,
                            categoryEg: category.categoryNameEng,
                            categoryAr: category.arabicName,
                            categoryImageUrl: category.image,
                            index: index);
                      },
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })),
    );
  }

  Widget _getCardByTitle(
      {CategoriesModalClass categoriesData,
      String categoryID,
      String categoryEg,
      String categoryAr,
      String categoryImageUrl,
      int index}) {
    return Container(
        height: 180,
        width: 180,
        padding:
            EdgeInsets.only(top: 5.0, bottom: 5.0, right: 15.0, left: 15.0),
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JsonParsingSimple(
                            categoryData: categoriesData,
                            categoryID: categoryID,
                            initialPosition: index,
                          )));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                    child: Container(
                        child: Image.network(
                      categoryImageUrl,
                      width: 100,
                      height: 100,
                    )),
                  ),
                  Text(
                    categoryEg,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    categoryAr,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )));
  }
}
