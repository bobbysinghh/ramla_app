import 'dart:convert';

import 'package:asset_app/api/modal/order_history_model.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:asset_app/widgets/order_history_item_card.dart';
import 'package:flutter/material.dart';

import 'api/Networking/network.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  Future<dynamic> dataString;
  @override
  void initState() {
    super.initState();
    dataString = NetworkWithHeaders(AppUrl.getOrderHistory).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 251, 247, 1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              "My Orders",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: dataString,
          builder: (builder, snapshot) {
            if (snapshot.hasData) {
              var decodeData = json.decode(snapshot.data);
              if (decodeData["statuscode"] == 1) {
                OrderHistoryModel orderHistoryDetails =
                    orderHistoryModelFromJson(snapshot.data);
                return Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 3,
                                  ),
                              itemCount: orderHistoryDetails.data.length,
                              itemBuilder: (context, index) => OrderHistoryCard(
                                    index: index,
                                    order: orderHistoryDetails.data[index],
                                  )),
                        ),
                      ),
                    ],
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
        ));
  }
}
