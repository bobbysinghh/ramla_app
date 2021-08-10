import 'package:asset_app/api/modal/order_history_model.dart';
import 'package:asset_app/screens/order_summary.dart';
import 'package:flutter/material.dart';

class OrderHistoryCard extends StatefulWidget {
  final int index;
  final Datum order;
  const OrderHistoryCard({Key key, this.index, this.order}) : super(key: key);

  @override
  State<OrderHistoryCard> createState() => _OrderHistoryCardState();
}

class _OrderHistoryCardState extends State<OrderHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderSummary(
                        orderID: widget.order.id,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.task_alt),
                        Text(widget.order.orderStatus),
                      ],
                    ),
                  ),
                  Text(widget.order.orderdate)
                ],
              ),
              Divider(thickness: 1, color: Colors.black.withOpacity(0.5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Number #${widget.order.id.substring(0, 7)}"),
                  Text("${widget.order} AED")
                ],
              ),
              Text("No. of items ${widget.order.itemCount}")
            ],
          )),
        ),
      ),
    );
  }
}
