import 'package:asset_app/Common/custom_text_field.dart';
import 'package:asset_app/api/Networking/network.dart';
import 'package:asset_app/api/config/config.dart';
import 'package:asset_app/api/modal/cart_get_details.dart';
import 'package:asset_app/api/modal/products_modal_class.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:asset_app/components/drawer.dart';
import 'package:asset_app/constants.dart';
import 'package:asset_app/widgets/cart_item_card.dart';
import 'package:asset_app/widgets/list_item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Future<dynamic> dataString;
  @override
  void initState() {
    super.initState();
    dataString =
        Network(AppUrl.getCartItems + Config.deviceID).fetchDataNotString();
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
              CartGetDetailsModel cartDetailModal =
                  cartGetDetailsModelFromJson(snapshot.data);
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
                        "Your Cart ${cartDetailModal.data.length}",
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
                          itemCount: cartDetailModal.data.length,
                          itemBuilder: (context, index) => CartItemCard(
                                index: index,
                                product: cartDetailModal.data[index],
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
