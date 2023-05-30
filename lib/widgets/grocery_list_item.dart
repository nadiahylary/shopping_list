import 'package:flutter/material.dart';

import '../models/grocery_item.dart';

class GroceriesList extends StatelessWidget {
  const GroceriesList({Key? key, required this.groceryItem}) : super(key: key);
  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.square,
            color: groceryItem.category.color,
            size: 40,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            groceryItem.name,
          ),
          const Spacer(),
          Text("${groceryItem.quantity}")
        ],
      ),
    );
  }
}
