import 'dart:convert';

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
import 'dart:convert';
import 'package:asset_app/api/providers/cart_provider.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        NetworkWithHeaders(AppUrl.getCartItems + Config.deviceID).fetchData();
  }

  String _id, _qty, _cuttingstyle_id, _queans, _cart_id;
  int changeIndicator = 0;

  Duration get registerTime =>
      Duration(milliseconds: timeDilation.ceil() * 2250);
  @override
  Widget build(BuildContext context) {
    CartProvider cart = Provider.of<CartProvider>(context);
    Future updateCart() async {
      if (double.parse(_qty) > 0.0) {
        Response response = await cart.updateCart(
            _id, _qty, _cuttingstyle_id, _queans, _cart_id);
        var data = jsonDecode(response.body);
        if (data['statuscode'] == 1) {
          Future.delayed(registerTime).then((_) {
            Fluttertoast.showToast(
              msg: data['message'],
              timeInSecForIosWeb: 5,
            );
            cart.notify();
          });
        } else {
          Fluttertoast.showToast(
            msg: data['message'],
            timeInSecForIosWeb: 5,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Quantity should be more than Minimum Order",
          timeInSecForIosWeb: 5,
        );
      }
    }

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
              var decodeData = json.decode(snapshot.data);
              if (decodeData["statuscode"] == 1) {
                CartGetDetailsModel cartDetailModal =
                    cartGetDetailsModelFromJson(snapshot.data);

                return SingleChildScrollView(
                  child: Container(
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
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              itemCount: cartDetailModal.data.length,
                              itemBuilder: (context, index) {
                                _id = cartDetailModal.data[index].productId;
                                _cart_id = cartDetailModal.data[index].id;
                                _cuttingstyle_id =
                                    cartDetailModal.data[index].cuttingstyleId;
                                _queans = cartDetailModal.data[index].queAns;
                                print(cartDetailModal.data[index].name);
                                return CartItemCard(
                                  index: index,
                                  product: cartDetailModal.data[index],
                                  valueSetter: (value) {
                                    setState(() {
                                      _qty = value;
                                    });
                                    updateCart();
                                    // print(_id);
                                    // print(_cart_id);
                                    // print(_qty);
                                    // print(_cuttingstyle_id);
                                    // print(_queans);
                                  },
                                  // product: itemCategories[0].products[index],
                                  // product: itemCategories[0]
                                  //     .products[index],
                                );
                              }),
                        ),
                        // SizedBox(
                        //   height: 600,
                        // )
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                    child: Center(
                  child: Text(decodeData["message"]),
                ));
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
