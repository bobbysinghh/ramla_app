import 'package:asset_app/api/modal/cart_get_details.dart';
import 'package:asset_app/constants.dart';
import 'package:asset_app/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatefulWidget {
  final int index;
  final Datum product;
  const CartItemCard({Key key, this.index, this.product}) : super(key: key);

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  double quantity;
  double incrementDecrementValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantity = double.parse(widget.product.baseQty);
    widget.product.weightUnit == " KG"
        ? incrementDecrementValue = 0.25
        : incrementDecrementValue = 1.0;
  }

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
                          widget.product.weightUnit == " KG"
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
              width: 150,
              height: 36,
              decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  border: Border.all(color: Color.fromRGBO(245, 131, 33, 1)),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
