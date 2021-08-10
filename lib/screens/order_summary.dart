import 'dart:convert';

import 'package:asset_app/api/Networking/network.dart';
import 'package:asset_app/api/modal/order_detail_model.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:flutter/material.dart';

class OrderSummary extends StatefulWidget {
  final String orderID;
  const OrderSummary({Key key, this.orderID}) : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  List<TableRow> createOrderItemTable(List<Item> items) {
    List<TableRow> itemProperties = [];
    for (int i = 0; i < items.length; ++i) {
      itemProperties.add(TableRow(children: [
        TableCell(child: Text("${items[i].productName}")),
        TableCell(child: Text("${items[i].weight}${items[i].unit}")),
        TableCell(child: Text("${items[i].amount} AED"))
      ]));
    }
    return itemProperties;
  }

  Future<dynamic> dataString;
  @override
  void initState() {
    super.initState();
    dataString = NetworkWithHeaders(AppUrl.getOrderDetail + '${widget.orderID}')
        .fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text("Order Summary"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: dataString,
        builder: (builder, snapshot) {
          if (snapshot.hasData) {
            var decodeData = json.decode(snapshot.data);
            if (decodeData["statuscode"] == 1) {
              OrderDetailModel orderDetail =
                  orderDetailModelFromJson(snapshot.data);
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 450,
                        padding: EdgeInsets.all(7),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Order Details"),
                                Text(orderDetail.data.id.substring(0, 7))
                              ],
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Order Date"),
                                Text(orderDetail.data.orderdate)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Payment Status"),
                                Text(orderDetail.data.paymentStatus)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("No. of Items"),
                                Text(orderDetail.data.itemCount)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Sub Total"),
                                Text("${orderDetail.data.orderAmount} AED")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Deliver Charge"),
                                Text("${orderDetail.data.shippingCharges} AED")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Grand Total"),
                                Text("${orderDetail.data.totalAmount} AED")
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(7),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(child: Text("Your Order")),
                            Divider(
                              thickness: 2,
                            ),
                            Table(
                              children:
                                  createOrderItemTable(orderDetail.data.items),
                            )
                            // rows: )
                            // Expanded(
                            //     child: Container(
                            //   width: 100,
                            //   child: ListView.builder(
                            //       itemCount: 27,
                            //       itemBuilder: (BuildContext context, int index) {
                            //         return Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //           children: [
                            //             Text("Apple Royal Gala"),
                            //             Text("2.5Kg"),
                            //             Text("20 AED")
                            //           ],
                            //         );
                            //       }),
                            // ))
                          ],
                        ),
                      )
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
          return CircularProgressIndicator();
        },
      )),
    );
  }
}
