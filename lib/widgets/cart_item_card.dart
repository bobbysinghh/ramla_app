import 'dart:convert';

import 'package:asset_app/api/modal/cart_get_details.dart';
import 'package:asset_app/api/providers/cart_provider.dart';
import 'package:asset_app/constants.dart';
import 'package:asset_app/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartItemCard extends StatefulWidget {
  final int changeIndicator;
  final int index;
  final Datum product;
  final ValueSetter valueSetter;
  const CartItemCard(
      {Key key,
      this.index,
      this.product,
      this.changeIndicator,
      this.valueSetter})
      : super(key: key);

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  double quantity;
  double incrementDecrementValue;
  String _id, _qty, _cuttingstyle_id, _queans, _cart_id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantity = double.parse(widget.product.weight);
    _id = widget.product.productId;
    _cuttingstyle_id = widget.product.cuttingstyleId;
    _queans = widget.product.queAns;
    _cart_id = widget.product.id;
    widget.product.weightUnit == "KG"
        ? incrementDecrementValue = 0.25
        : incrementDecrementValue = 1.0;
  }

  Duration get registerTime =>
      Duration(milliseconds: timeDilation.ceil() * 2250);
  @override
  Widget build(BuildContext context) {
    // CartProvider cart = Provider.of<CartProvider>(context);
    // Future updateCart() async {
    //   if (quantity >= 0.0) {
    //     Response response = await cart.updateCart(
    //         _id, _qty, _cuttingstyle_id, _queans, _cart_id);
    //     var data = jsonDecode(response.body);
    //     if (data['statuscode'] == 1) {
    //       Future.delayed(registerTime).then((_) {
    //         Fluttertoast.showToast(
    //           msg: data['message'],
    //           timeInSecForIosWeb: 5,
    //         );
    //         cart.cartItemInStatus = CartStatus.Updated;
    //         cart.notify();
    //       });
    //     } else {
    //       Fluttertoast.showToast(
    //         msg: data['message'],
    //         timeInSecForIosWeb: 5,
    //       );
    //     }
    //   } else {
    //     Fluttertoast.showToast(
    //       msg: "Quantity should be more than Minimum Order",
    //       timeInSecForIosWeb: 5,
    //     );
    //   }
    // }

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Image.network(
                    widget.product.image,
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    // color: Colors.red,
                    width: 115,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: kstyle(
                              fontSize: 20,
                              color: Color.fromRGBO(67, 67, 67, 1),
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.product.weightUnit == "KG"
                              ? "${widget.product.price.toStringAsFixed(2)}/kg"
                              : "${widget.product.price.toStringAsFixed(2)}/piece",
                          style: kstyle(
                              fontSize: 18,
                              color: Color.fromRGBO(245, 131, 33, 1),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: 150,
                  height: 36,
                  decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      border:
                          Border.all(color: Color.fromRGBO(245, 131, 33, 1)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton(
                          minWidth: 1,
                          onPressed: () {
                            if (quantity != 0.0) {
                              setState(() {
                                quantity -= incrementDecrementValue;
                                _qty = quantity.toString();
                              });
                              widget.valueSetter(_qty);
                              // updateCart();
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
                              _qty = quantity.toString();
                            });
                            widget.valueSetter(_qty);
                            print(quantity);
                            // updateCart();
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
                IconButton(
                    onPressed: () {},
                    icon: Row(children: [Icon(Icons.delete), Text(" Delete")]))
              ],
            ),
          ],
        ),
      ),
    );
  }

  // _showAddOns(BuildContext context, String productID) {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(40), topRight: Radius.circular(40))),
  //       context: context,
  //       builder: (BuildContext context) {
  //         return MapModalBottomSheet(
  //           productID: productID,
  //         );
  //       });
  // }
}
