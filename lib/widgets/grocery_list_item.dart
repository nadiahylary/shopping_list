import 'package:flutter/material.dart';

import '../models/grocery_item.dart';

class GroceryListItem extends StatelessWidget {
  const GroceryListItem({Key? key, required this.groceryItem}) : super(key: key);
  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
            Icons.square,
            color: groceryItem.category.color,
            size: 35,
          ),
         title: Text(
            groceryItem.name,
          ),
         trailing: Text("${groceryItem.quantity}")
    );
  }
}
