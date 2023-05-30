import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/grocery_list_item.dart';

import '../data/random_data.dart';

class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NH's Groceries"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GroceriesList(groceryItem: groceryItems[index]);
        },
        itemCount: groceryItems.length,
      ),
    );
  }
}
