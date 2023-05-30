import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/grocery_list_item.dart';
import 'package:shopping_list/widgets/new_grocery_item.dart';

import '../data/random_data.dart';

class GroceriesList extends StatelessWidget {
  const GroceriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NH's Groceries"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GroceryListItem(groceryItem: groceryItems[index]);
        },
        itemCount: groceryItems.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const NewGroceryItem()));
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
