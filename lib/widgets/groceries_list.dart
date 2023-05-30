import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/grocery_list_item.dart';
import 'package:shopping_list/widgets/new_grocery_item.dart';

//import '../data/random_data.dart';
import '../models/grocery_item.dart';

class GroceriesList extends StatefulWidget {
  const GroceriesList({Key? key}) : super(key: key);

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  final List<GroceryItem> _groceryItems = [];

  void _newItemScreen() async {
    final newGroceryItem = await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => const NewGroceryItem()));

    if(newGroceryItem == null){
      return;
    }
    setState(() {
      _groceryItems.add(newGroceryItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GrowXery"),
        actions: [
          IconButton(
            onPressed: _newItemScreen,
            icon: const Icon(
              Icons.add,
              size: 30,
            ),

          ),
          /*IconButton( //todo
              onPressed: (){

              },
              icon: Icon(
                Icons.menu
              )
          )*/
        ],
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GroceryListItem(groceryItem: _groceryItems[index]);
        },
        itemCount: _groceryItems.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _newItemScreen,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
