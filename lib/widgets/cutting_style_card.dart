// import 'package:flutter/material.dart';

// class CuttingStyleCard extends StatefulWidget {
//   final bool longPressEnabled;
//   final VoidCallback callback;
//   // Function onChanged;
//   String cuttingStyle;
//   double addOnPrice;
//   String imageUrl;
//   final int index;
//   CuttingStyleCard({
//     Key key,
//     this.cuttingStyle,
//     this.addOnPrice,
//     this.imageUrl,
//     this.callback,
//     this.index,
//     this.longPressEnabled,
//     // required this.onChanged
//   }) : super(key: key);

//   @override
//   _CuttingStyleCardState createState() => _CuttingStyleCardState();
// }

// class _CuttingStyleCardState extends State<CuttingStyleCard> {
//   // Color colorCard = Colors.white;
//   bool selected = false;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: Card(
//         elevation: 10,
//         child: Ink(
//           child: InkWell(
//             onTap: () {
//               if (widget.longPressEnabled) {
//                 setState(() {
//                   selected = !selected;
//                 });
//                 widget.callback();
//               }
//             },
//             // onLongPress: () {
//             //   setState(() {
//             //     selected = !selected;
//             //   });
//             //   widget.callback();
//             // },
//             child: Container(
//               padding: EdgeInsets.all(10),
//               // color: colorCard,
//               decoration: selected
//                   ? new BoxDecoration(
//                       color: Colors.black38,
//                       border: new Border.all(color: Colors.black))
//                   : new BoxDecoration(),
//               width: (MediaQuery.of(context).size.width - (10 * 10)) / 4,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.network(
//                     widget.imageUrl,
//                     height: 70,
//                     width: 70,
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     widget.cuttingStyle,
//                     style: TextStyle(
//                         fontSize: 11,
//                         color: Color.fromRGBO(67, 67, 67, 1),
//                         fontWeight: FontWeight.w800),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     "${widget.addOnPrice} aed".toUpperCase(),
//                     style: TextStyle(
//                         fontSize: 11,
//                         color: Color.fromRGBO(67, 67, 67, 1),
//                         fontWeight: FontWeight.w800),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
