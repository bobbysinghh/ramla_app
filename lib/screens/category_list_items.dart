import 'package:asset_app/api/modal/products_modal_class.dart';
// import 'package:asset_app/modal/item_categories.dart';
import 'package:flutter/material.dart';
import '/widgets/list_item_card.dart';

class CategoryListItems extends StatefulWidget {
  final List<Datum> productList;
  const CategoryListItems({Key key, this.productList}) : super(key: key);

  @override
  State<CategoryListItems> createState() => _CategoryListItemsState();
}

class _CategoryListItemsState extends State<CategoryListItems>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 3,
                      ),
                  itemCount: widget.productList.length,
                  itemBuilder: (context, index) => ListItemsCard(
                        index: index,
                        product: widget.productList[index],
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
