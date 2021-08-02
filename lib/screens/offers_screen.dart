import 'package:asset_app/Common/custom_text_field.dart';
import 'package:asset_app/api/Networking/network.dart';
import 'package:asset_app/api/modal/products_modal_class.dart';
import 'package:asset_app/components/drawer.dart';
import 'package:asset_app/constants.dart';
import 'package:asset_app/widgets/list_item_card.dart';
import 'package:flutter/material.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({Key key}) : super(key: key);

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  Future<dynamic> dataString;
  @override
  void initState() {
    super.initState();
    dataString = Network(
            "https://ramla.thehirely.com/api/products/byCategoryId/3de472f5-482b-44ed-a841-ebd81f616331")
        .fetchData();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = new TextEditingController();
    return Scaffold(
      drawer: Drawer(
        child: pBody(),
      ),
      appBar: searchAppBar(
          backgroundColor: kPrimaryColor, controller: _searchController),
      backgroundColor: Color.fromRGBO(255, 251, 247, 1),
      body: FutureBuilder(
          future: dataString,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ProductsModalClass productsModal =
                  productsModalClassFromJson(snapshot.data);
              return Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      // padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Today's Offers",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 230,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: productsModal.data.length - 1,
                          itemBuilder: (context, index) => ListItemsCard(
                                index: index,
                                product: productsModal.data[index],
                                // product: itemCategories[0].products[index],
                                // product: itemCategories[0]
                                //     .products[index],
                              )),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
