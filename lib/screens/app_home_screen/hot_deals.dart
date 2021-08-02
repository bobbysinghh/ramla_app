import 'package:asset_app/api/Networking/network.dart';
import 'package:asset_app/api/modal/products_modal_class.dart';
import 'package:asset_app/widgets/list_item_card.dart';
import 'package:flutter/material.dart';

class HotDeals extends StatefulWidget {
  const HotDeals({Key key}) : super(key: key);

  @override
  _HotDealsState createState() => _HotDealsState();
}

class _HotDealsState extends State<HotDeals> {
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
    return FutureBuilder(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("Hot Deals"),
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
          return Container();
          // return Center(
          //   child: CircularProgressIndicator(),
          // );
        });
  }
}
