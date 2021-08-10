import 'dart:convert';

import 'package:asset_app/Common/custom_text_field.dart';
import 'package:asset_app/api/Networking/network.dart';
import 'package:asset_app/api/modal/delivery_location_modal.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:asset_app/components/drawer.dart';
import 'package:asset_app/constants.dart';
import 'package:flutter/material.dart';

class DeliveryLocationScreen extends StatefulWidget {
  const DeliveryLocationScreen({Key key}) : super(key: key);

  @override
  _DeliveryLocationScreenState createState() => _DeliveryLocationScreenState();
}

class _DeliveryLocationScreenState extends State<DeliveryLocationScreen> {
  Future<dynamic> dataString;
  @override
  void initState() {
    super.initState();
    dataString = Network(AppUrl.getDeliveryLocation).fetchData();
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
              var decodeData = json.decode(snapshot.data);
              if (decodeData["statuscode"] == 1) {
                DeliveryLocationlModel deliveryLocationlDetails =
                    deliveryLocationlModelFromJson(snapshot.data);
                var _deliveryLocation = deliveryLocationlDetails.data.list[0];
                var amount;
                return Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Delivery Location",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            new Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.assessment_outlined))
                          ]),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            itemCount:
                                deliveryLocationlDetails.data.list.length,
                            itemBuilder: (context, index) => ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${deliveryLocationlDetails.data.list[index].name}, ${deliveryLocationlDetails.data.list[index].community},")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              "${deliveryLocationlDetails.data.list[index].area}, ${deliveryLocationlDetails.data.list[index].deliverycenter},")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              "${deliveryLocationlDetails.data.list[index].emirate},")
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Radio(
                                    value: deliveryLocationlDetails
                                        .data.list[index],
                                    groupValue: _deliveryLocation,
                                    onChanged: (var value) {
                                      setState(() {
                                        _deliveryLocation = value;
                                      });
                                    },
                                  ),
                                )),
                      ),
                      new Spacer(),
                      Row(
                        children: [
                          Text("My Address is not listed. "),
                          InkWell(
                            onTap: () {},
                            child: Text("Suggest Location"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          customButton(name: "Continue Shop", callback: () {}),
                          customButton(
                              name: "Pay ${amount.toString()} AED",
                              callback: () {})
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  child: Center(
                    child: Row(
                      children: [
                        Text("My Address is not listed. "),
                        InkWell(
                          onTap: () {},
                          child: Text("Suggest Location"),
                        )
                      ],
                    ),
                  ),
                );
              }
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
