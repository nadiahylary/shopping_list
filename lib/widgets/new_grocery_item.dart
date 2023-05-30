import 'package:flutter/material.dart';

class NewGroceryItem extends StatefulWidget {
  const NewGroceryItem({Key? key}) : super(key: key);

  @override
  State<NewGroceryItem> createState() => _NewGroceryItemState();
}

class _NewGroceryItemState extends State<NewGroceryItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("New Grocery Item"),
    ),
    body: const Padding(
      padding: EdgeInsets.all(8),
      child: Text("New Grocery Item"),
    ),
    );
}
