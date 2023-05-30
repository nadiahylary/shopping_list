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
  void _deleteGroceryItem(GroceryItem groceryItem) {
    final groceryItemIndex = _groceryItems.indexOf(groceryItem);
    setState(() {
      _groceryItems.remove(groceryItem);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      duration: const Duration(seconds: 3),
      content: const Text("Grocery Item Deleted."),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _groceryItems.insert(groceryItemIndex, groceryItem);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {

    Widget mainContent = Center(
      child: Container(
        height: 400,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/images/empty-shopping-cart.png",
              //fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "You have no grocery item yet.",
            ),
          ],
        ),
      ),
    );

    if (_groceryItems.isNotEmpty) {
      mainContent = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.5),
          ),
          onDismissed: (direction){
            _deleteGroceryItem( _groceryItems[index]);
          },
          key: ObjectKey(_groceryItems[index]),
          child: GroceryListItem(groceryItem: _groceryItems[index])
          );
        },
        itemCount: _groceryItems.length,
      );
    }

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
      body: mainContent,
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
