import 'package:asset_app/api/modal/products_modal_class.dart';
import 'package:asset_app/constants.dart';
import 'package:asset_app/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ListItemsCard extends StatefulWidget {
  final int index;
  final Datum product;
  const ListItemsCard({Key key, this.index, this.product}) : super(key: key);

  @override
  _ListItemsCardState createState() => _ListItemsCardState();
}

class _ListItemsCardState extends State<ListItemsCard> {
  @override
  Widget build(BuildContext context) {
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
                    width: 185,
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
                          widget.product.unit == " KG"
                              ? "${widget.product.price}/kg"
                              : "${widget.product.price}/piece",
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
            Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(248, 200, 34, 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: FlatButton(
                    onPressed: () {
                      _showAddOns(context, widget.product.id);
                    },
                    child: Text(
                      "add".toUpperCase(),
                      style: kstyle(color: Colors.black),
                    ),
                    color: Colors.transparent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showAddOns(BuildContext context, String productID) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        context: context,
        builder: (BuildContext context) {
          return MapModalBottomSheet(
            productID: productID,
          );
        });
  }
}
