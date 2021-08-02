import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({Key key}) : super(key: key);

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
          child: SingleChildScrollView(
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Order Details"), Text("order Id")],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Order Date"), Text("order date")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Order Date"), Text("order date")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Order Date"), Text("order date")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Order Date"), Text("order date")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Order Date"), Text("order date")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Apple Royal Gala"),
                        Text("2.5Kg"),
                        Text("20 AED")
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 430 / 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ash Guard (Kumbalam)"),
                              Text("500gm")
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 430 / 5,
                          child: Row(
                            children: [Text("200 AED")],
                          ),
                        )
                      ],
                    )
                    // Row(
                    //   children: [
                    //     Container(
                    //         width:
                    //             (MediaQuery.of(context).size.width - 44) * 0.4,
                    //         child: Text("Ash Guard (Kumbalam)")),
                    //     Container(
                    //         width:
                    //             (MediaQuery.of(context).size.width - 44) * 0.25,
                    //         child: Text("500gm")),
                    //     Container(
                    //         width:
                    //             (MediaQuery.of(context).size.width - 44) * 0.35,
                    //         child: Positioned(right: 0, child: Text("12 AED")))
                    //   ],
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Container(
              //   padding: EdgeInsets.all(7),
              //   color: Colors.white,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Container(child: Text("Your Order")),
              //       Divider(
              //         thickness: 2,
              //       ),
              //       Expanded(
              //           child: Container(
              //         width: 100,
              //         child: ListView.builder(
              //             itemCount: 27,
              //             itemBuilder: (BuildContext context, int index) {
              //               return Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                 children: [
              //                   Text("Apple Royal Gala"),
              //                   Text("2.5Kg"),
              //                   Text("20 AED")
              //                 ],
              //               );
              //             }),
              //       ))
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      )),
    );
  }
}
