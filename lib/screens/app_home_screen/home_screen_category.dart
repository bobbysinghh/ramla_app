import 'package:asset_app/api/Networking/network.dart';
import 'package:asset_app/api/modal/categories_modal_class.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:asset_app/modal/parsing_json/json_parsing_simple.dart';
import 'package:flutter/material.dart';

class HomeScreenCategories extends StatefulWidget {
  const HomeScreenCategories({Key key}) : super(key: key);

  @override
  _HomeScreenCategoriesState createState() => _HomeScreenCategoriesState();
}

class _HomeScreenCategoriesState extends State<HomeScreenCategories> {
  Future<dynamic> dataString;
  @override
  void initState() {
    super.initState();
    dataString = Network(AppUrl.allCategories).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dataString,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CategoriesModalClass categoriesmodal =
                categoriesModalClassFromJson(snapshot.data);
            // print(categoriesmodal.data.length.toString());
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("Categories")),
                  SizedBox(height: 10),
                  Container(
                      height: 180,
                      child: ListView.separated(
                        itemCount: categoriesmodal.data.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 0,
                        ),
                        itemBuilder: (context, index) {
                          var category = categoriesmodal.data[index];
                          // return _getCardByTitle(
                          //   categoryID: category.id,
                          //   categoryEg: category.categoryNameEng,
                          //   categoryAr: category.arabicName,
                          //   categoryImageUrl: category.image,
                          // );
                          return _getCardByTitle(
                              categoriesData: categoriesmodal,
                              categoryID: category.id,
                              categoryEg: category.categoryNameEng,
                              categoryAr: category.arabicName,
                              categoryImageUrl: category.image,
                              index: index);
                        },
                      ))
                ],
              ),
            );
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

//   Widget _getCardByTitle(
//       {CategoriesModalClass categoriesData,
//       String categoryID,
//       String categoryEg,
//       String categoryAr,
//       String categoryImageUrl,
//       int index}) {
//     print("$categoryEg $categoryID");
//     return Container(
//         height: 180,
//         width: 180,
//         padding:
//             EdgeInsets.only(top: 5.0, bottom: 5.0, right: 15.0, left: 15.0),
//         child: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => JsonParsingSimple(
//                             categoryID: categoryID,
//                             initialPosition: index,
//                           )));
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15.0),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 3.0,
//                         blurRadius: 5.0)
//                   ],
//                   color: Colors.white),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   new Center(
//                     child: Container(
//                         child: Image.network(
//                       categoryImageUrl,
//                       width: 100,
//                       height: 100,
//                     )),
//                   ),
//                   Text(
//                     categoryEg,
//                     style:
//                         TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(
//                     categoryAr,
//                     style:
//                         TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             )));
//   }
// }

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
