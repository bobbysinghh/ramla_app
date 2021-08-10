import 'dart:convert';

import 'package:asset_app/api/Networking/network.dart';
import 'package:asset_app/api/config/config.dart';
import 'package:asset_app/api/modal/cart_add_item.dart';
import 'package:asset_app/api/providers/cart_provider.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:asset_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MapModalBottomSheet extends StatefulWidget {
  final String productID;
  const MapModalBottomSheet({Key key, this.productID}) : super(key: key);

  @override
  _MapModalBottomSheetState createState() => _MapModalBottomSheetState();
}

class _MapModalBottomSheetState extends State<MapModalBottomSheet> {
  String _id, _qty, _cuttingstyle_id, _queans;
  Future<dynamic> dataString;
  String productId;
  @override
  void initState() {
    super.initState();
    productId = widget.productID;
    dataString =
        Network(AppUrl.productDetails + productId).fetchDataNotString();
  }

  // CartProducts cartProducts = new CartProducts();
  bool longPressFlag = false;
  List<int> indexList = [];

  void longPress() {
    setState(() {
      if (indexList.isEmpty) {
        longPressFlag = false;
      } else {
        longPressFlag = true;
      }
    });
  }

  double quantity = 0.0;
  var data;
  int selectedIndex = -1;
  bool ques1 = false;
  bool ques2 = false;
  Duration get registerTime =>
      Duration(milliseconds: timeDilation.ceil() * 2250);
  @override
  Widget build(BuildContext context) {
    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Adding Item to Cart")
      ],
    );
    CartProvider cart = Provider.of<CartProvider>(context);
    Future addToCart(double minOrder) async {
      if (quantity >= minOrder) {
        Response response =
            await cart.addToCart(_id, _qty, _cuttingstyle_id, _queans);
        var data = jsonDecode(response.body);
        if (data['statuscode'] == 1) {
          Future.delayed(registerTime).then((_) {
            Fluttertoast.showToast(
              msg: data['message'],
              timeInSecForIosWeb: 5,
            );
            cart.cartItemInStatus = CartStatus.AddedIn;
            cart.notify();
            Navigator.pop(context);
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

    return FutureBuilder(
        future: dataString,
        builder: (builder, snapshot) {
          if (snapshot.hasData) {
            double incrementDecrementValue;
            snapshot.data["data"]["Unit"] == " KG"
                ? incrementDecrementValue = 0.25
                : incrementDecrementValue = 1.0;
            return Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Image.network(
                    snapshot.data["data"]["Image"],
                    height: 150,
                    width: 150,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapshot.data["data"]["Name"],
                        style: kstyle(
                            fontSize: 20,
                            color: Color.fromRGBO(67, 67, 67, 1),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      snapshot.data["data"]["Unit"] == ' KG'
                          ? Text(
                              "${snapshot.data["data"]["Price"]}/Kg",
                              style: kstyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(245, 131, 33, 1),
                                  fontWeight: FontWeight.w800),
                            )
                          : Text(
                              "${snapshot.data["data"]["Price"]}/piece",
                              style: kstyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(245, 131, 33, 1),
                                  fontWeight: FontWeight.w800),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   product.,
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.black.withOpacity(0.5)),
                  snapshot.data["data"]["cuttingstyle"] != "N\/A"
                      ? Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: Column(children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Cutting Styles",
                                  style: kstyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(67, 67, 67, 1),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                height: 150,
                                child: ListView.separated(
                                  itemCount: snapshot
                                      .data["data"]["cuttingstyle"].length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    bool isItemSelected =
                                        index == selectedIndex;
                                    return Card(
                                      elevation: 10,
                                      child: Ink(
                                        child: InkWell(
                                          onTap: () {
                                            if (selectedIndex == index) {
                                              setState(() {
                                                selectedIndex = -1;
                                              });
                                            } else {
                                              setState(() {
                                                selectedIndex = index;
                                              });
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: isItemSelected
                                                ? new BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: FractionalOffset
                                                          .topCenter,
                                                      end: FractionalOffset
                                                          .bottomCenter,
                                                      colors: [
                                                        Colors.orange
                                                            .withOpacity(0.1),
                                                        Colors.orange
                                                            .withOpacity(0.5),
                                                      ],
                                                    ),
                                                  )
                                                : new BoxDecoration(),
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    (5 * 10)) /
                                                4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Image.network(
                                                //   snapshot.data["data"]["cuttingstyle"][index]["Image"],
                                                //   height: 70,
                                                //   width: 70,
                                                // ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  snapshot.data["data"]
                                                          ["cuttingstyle"]
                                                      [index]["Name"],
                                                  style: kstyle(
                                                      fontSize: 11,
                                                      color: Color.fromRGBO(
                                                          67, 67, 67, 1),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${snapshot.data["data"]["cuttingstyle"][index]["Price"]} aed"
                                                      .toUpperCase(),
                                                  style: kstyle(
                                                      fontSize: 11,
                                                      color: Color.fromRGBO(
                                                          67, 67, 67, 1),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                                thickness: 1,
                                color: Colors.black.withOpacity(0.5)),
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    "Tell us more about it",
                                    style: kstyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(67, 67, 67, 1),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Do you want to remove seeds?",
                                        style: kstyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          ButtonTheme(
                                            minWidth: 30,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              onPressed: () {
                                                setState(() {
                                                  ques1 = true;
                                                });
                                              },
                                              child: Text(
                                                "Yes",
                                                style: kstyle(
                                                    fontSize: 15,
                                                    color: ques1
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                              color: ques1
                                                  ? Color.fromRGBO(
                                                      245, 131, 33, 1)
                                                  : Colors.white,
                                            ),
                                          ),
                                          ButtonTheme(
                                            minWidth: 30,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              onPressed: () {
                                                setState(() {
                                                  ques1 = false;
                                                });
                                              },
                                              child: Text(
                                                "No",
                                                style: kstyle(
                                                    fontSize: 15,
                                                    color: !ques1
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                              color: !ques1
                                                  ? Color.fromRGBO(
                                                      245, 131, 33, 1)
                                                  : Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Do you want to remove skin?",
                                        style: kstyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          ButtonTheme(
                                            minWidth: 30,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              onPressed: () {
                                                setState(() {
                                                  ques2 = true;
                                                });
                                              },
                                              child: Text(
                                                "Yes",
                                                style: kstyle(
                                                    fontSize: 15,
                                                    color: ques2
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                              color: ques2
                                                  ? Color.fromRGBO(
                                                      245, 131, 33, 1)
                                                  : Colors.white,
                                            ),
                                          ),
                                          ButtonTheme(
                                            minWidth: 30,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              onPressed: () {
                                                setState(() {
                                                  ques2 = false;
                                                });
                                              },
                                              child: Text(
                                                "No",
                                                style: kstyle(
                                                    fontSize: 15,
                                                    color: !ques2
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                              color: !ques2
                                                  ? Color.fromRGBO(
                                                      245, 131, 33, 1)
                                                  : Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 36,
                              decoration: BoxDecoration(
                                  color: Colors.orange.shade100,
                                  border: Border.all(
                                      color: Color.fromRGBO(245, 131, 33, 1)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FlatButton(
                                      minWidth: 1,
                                      onPressed: () {
                                        if (quantity != 0) {
                                          setState(() {
                                            quantity -= incrementDecrementValue;
                                          });
                                        }
                                        print(quantity);
                                      },
                                      child: Container(
                                        child: Text(
                                          "-",
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "$quantity",
                                      style: kstyle(fontSize: 16),
                                    ),
                                    FlatButton(
                                      minWidth: 1,
                                      onPressed: () {
                                        setState(() {
                                          quantity += incrementDecrementValue;
                                        });
                                        print(quantity);
                                      },
                                      child: Container(
                                        child: Text(
                                          "+",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            snapshot.data["data"]["Unit"] == " KG"
                                ? Text(
                                    "Min order ${snapshot.data["data"]["Minorder"]} Kg",
                                    style: kstyle(fontSize: 12),
                                  )
                                : Text(
                                    "Min order ${snapshot.data["data"]["Minorder"]} piece",
                                    style: kstyle(fontSize: 12),
                                  )
                          ],
                        ),
                      ),
                      cart.cartItemInStatus == CartStatus.Adding
                          ? loading
                          : InkWell(
                              onTap: () {
                                print(Config.fcmToken);
                                print(Config.deviceID);
                                if (snapshot.data["data"]["cuttingstyle"] ==
                                        "N\/A" &&
                                    selectedIndex == -1) {
                                  _id = productId;
                                  _qty = quantity.toString();
                                  _cuttingstyle_id = "";
                                  _queans = "";
                                } else if (snapshot.data["data"]
                                        ["cuttingstyle"] ==
                                    "N\/A") {
                                  _id = productId;
                                  _qty = quantity.toString();
                                  _cuttingstyle_id = "";
                                  _queans = "";
                                } else {
                                  _id = productId;
                                  _qty = quantity.toString();
                                  _cuttingstyle_id = snapshot.data["data"]
                                      ["cuttingstyle"][selectedIndex]["Guid"];
                                  _queans = "";
                                }
                                addToCart(double.parse(
                                    snapshot.data["data"]["Minorder"]));
                                // var cartProvider = Provider.of<CartProvider>(
                                //     context,
                                //     listen: false);
                                // if (selectedIndex == -1) {
                                //   cartProducts.id = productId;
                                //   cartProducts.cuttingstyleId =
                                // snapshot.data["data"]["cuttingstyle"]
                                //     [selectedIndex]["cuttingstyleID"];
                                //   cartProducts.qty = quantity.toString();
                                //   cartProducts.queans = "";
                                //   cartProducts.extraQty = "";
                                // } else if (snapshot.data["data"]["cuttingstyle"] !=
                                //     "N\/A") {
                                //   cartProducts.id = productId;
                                //   cartProducts.cuttingstyleId = "";
                                //   cartProducts.qty = quantity.toString();
                                //   cartProducts.queans = "";
                                //   cartProducts.extraQty = "";
                                // } else {
                                //   cartProducts.id = productId;
                                //   cartProducts.cuttingstyleId = "";
                                //   cartProducts.qty = "";
                                //   cartProducts.queans = "";
                                //   cartProducts.extraQty = "";
                                // }
                                // cartProvider.addToCart(cartProducts, (val) {
                                //   print(val);
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(245, 131, 33, 1),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 50,
                                width: 200,
                                child: Center(
                                    child: selectedIndex == -1
                                        ? Text(
                                            "add ${double.parse((quantity * double.parse(snapshot.data["data"]["Price"])).toStringAsFixed(2))} aed"
                                                .toUpperCase(),
                                            style: kstyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )
                                        // : Text("some value")
                                        : snapshot.data["data"]
                                                    ["cuttingstyle"] !=
                                                "N\/A"
                                            ? Text(
                                                "add ${double.parse((quantity * double.parse(snapshot.data["data"]["Price"]) + double.parse(snapshot.data["data"]["cuttingstyle"][selectedIndex]["Price"])).toStringAsFixed(2))} aed"
                                                    .toUpperCase(),
                                                style: kstyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            : Text("data")),
                              ))
                    ],
                  )
                ],
              ),
            );
          }

          return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              child: Center(child: CircularProgressIndicator()));
        });
  }
}
