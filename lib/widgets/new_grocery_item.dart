import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/data/random_data.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/groceries_list.dart';

import '../models/category.dart';

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


  void _saveGroceryItem(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      GroceryItem newItem = GroceryItem(id: "g20", name: _enteredName, quantity: _enteredQty, category: _selectedCategory);
      Navigator.of(context).pop(
        newItem
      );
      //Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const GroceriesList()));
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
                          onPressed: (){
                            Navigator.of(context).pop();
                            //_formKey.currentState!.reset();
                          },
                          child: const Text("Cancel")),
                      const SizedBox(
                        width: 35,
                      ),
                      TextButton(
                          onPressed: (){
                            _formKey.currentState!.reset();
                          },
                          child: const Text("Reset")),
                      const SizedBox(
                        width: 35,
                      ),
                      ElevatedButton(
                          onPressed: _saveGroceryItem,
                          child: const Text("Add Item")
                      ),
                    ],
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
