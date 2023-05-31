import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import '../models/category.dart';
import 'package:http/http.dart' as http;

class NewGroceryItem extends StatefulWidget {
  const NewGroceryItem({Key? key}) : super(key: key);

  @override
  State<NewGroceryItem> createState() => _NewGroceryItemState();
}

class _NewGroceryItemState extends State<NewGroceryItem> {
  final _formKey = GlobalKey<FormState>();
  String _enteredName = '';
  int _enteredQty = 1;
  Category _selectedCategory = categories[Categories.hygiene]!;
  var _isSending = false;


  void _saveGroceryItem() async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https(
          'flutter-meals-app-e9e6f-default-rtdb.europe-west1.firebasedatabase.app',
          'shopping-list.json'
      );
      try{
        final response = await http.post(
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'name': _enteredName,
              'quantity': _enteredQty,
              'category': _selectedCategory.title,
            })
        );

        if(!context.mounted){
          return;
        }
        final Map<String, dynamic> itemData = json.decode(response.body);

        GroceryItem newItem = GroceryItem(
            id: itemData['name'],
            name: _enteredName,
            quantity: _enteredQty,
            category: _selectedCategory
        );
        Navigator.of(context).pop(
            newItem
        );
      }catch(e){
        setState(() {
          Text(e.toString());
        });
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Grocery Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text("Name"),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty || value.trim().length <= 1 || value.trim().length > 50){
                        return "Please enter a name of 2 to 50 characters long";
                      }
                      return null;
                    },
                    onSaved: (value){
                      _enteredName = value!;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text("Quantity"),
                            ),
                            initialValue: _enteredQty.toString(),
                            keyboardType: TextInputType.number,
                            validator: (value){
                              if(value == null || value.isEmpty || int.tryParse(value) == null || int.tryParse(value)! <= 0){
                                return "Please enter a valid integer > 0";
                              }
                              return null;
                            },
                            onSaved: (value){
                              _enteredQty = int.parse(value!);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              label: Text("Category")
                            ),
                            value: _selectedCategory,
                            items: [
                                for (final category in categories.entries)
                                  DropdownMenuItem(
                                    value: category.value,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.square,
                                            color: category.value.color,
                                            size: 35,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(category.value.title),
                                      ]
                                    )
                                  )
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value!;
                                });
                              },
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: _isSending ? null : (){
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel")),
                      const SizedBox(
                        width: 35,
                      ),
                      TextButton(
                          onPressed: _isSending ? null : (){
                            _formKey.currentState!.reset();
                          },
                          child: const Text("Reset")),
                      const SizedBox(
                        width: 35,
                      ),
                      ElevatedButton(
                          onPressed: _isSending ? null : _saveGroceryItem,
                          child: _isSending ? const SizedBox(
                            width: 20,
                            height: 16,
                            child: CircularProgressIndicator(),
                          ) : const Text("Add Item")
                      ),
                    ],
                  ),

                ],
              ),
            )
        ),
      ),
    );
  }
}
