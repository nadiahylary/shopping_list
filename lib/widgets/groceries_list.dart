import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/widgets/grocery_list_item.dart';
import 'package:shopping_list/widgets/new_grocery_item.dart';
import 'package:http/http.dart' as http;
import '../models/grocery_item.dart';

class GroceriesList extends StatefulWidget {
  const GroceriesList({Key? key}) : super(key: key);

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadGroceryItems();
  }

  void _loadGroceryItems() async{
    final url = Uri.https(
        'flutter-meals-app-e9e6f-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json'
    );
    try{
      final response = await http.get(url);
      if(response.statusCode >= 400){
        setState(() {
          _error = "Failed to fetch the data. Please try again later.";
        });
      }
      if(response.body == "null"){
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final Map<String, dynamic> groceryData = json.decode(response.body);
      final List<GroceryItem> loadedGroceryItems = [];
      for(final item in groceryData.entries){
        final category = categories.entries.firstWhere(
                (catItem) => catItem.value.title == item.value['category']).value;
        GroceryItem groceryItem = GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category
        );
        loadedGroceryItems.add(groceryItem);
      }
      setState(() {
        _groceryItems = loadedGroceryItems;
        _isLoading = false;
      });
    } catch(error){
      setState(() {
        _error = "Something went wrong! Please try again later.";
      });
    }

  }

  void _newItemScreen() async {
    final newGroceryItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewGroceryItem()));
    if(newGroceryItem == null){
      return;
    }
    setState(() {
      _groceryItems.add(newGroceryItem);
    });
  }
  void _deleteGroceryItem(GroceryItem groceryItem) async {
    final groceryItemIndex = _groceryItems.indexOf(groceryItem);
    setState(() {
      _groceryItems.remove(groceryItem);
    });

    final url = Uri.https(
        'flutter-meals-app-e9e6f-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list/${groceryItem.id}.json'
    );
    final response = await http.delete(url);
    if(response.statusCode >= 400){
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            duration: const Duration(seconds: 3),
            content: const Text("Couldn't delete Grocery Item."),
          )
      );
      setState(() {
        _groceryItems.insert(groceryItemIndex, groceryItem);
      });
    }
    /*ScaffoldMessenger.of(context).clearSnackBars();
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
    ));*/
  }

  @override
  Widget build(BuildContext context) {

    Widget mainContent = Center(
      child: Container(
        height: 400,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/empty-shopping-cart.png",
              //fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "You have no groceries items yet.",
            ),
          ],
        ),
      ),
    );

    if(_isLoading){
      mainContent = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if(_error != null){
      mainContent = Center(
        child: Text(_error!),
      );
    }

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
        title: const Text("Grow-Xery"),
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
