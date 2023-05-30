import 'package:flutter/material.dart';
import 'package:shopping_list/models/category.dart';

final categories = {
  Categories.vegetables: Category(
    title: 'Vegetables',
    color: const Color.fromARGB(255, 0, 255, 128),
  ),
  Categories.fruit: Category(
    title: 'Fruit',
    color: Colors.red[400]!,
  ),
  Categories.meat: Category(
    title: 'Meat',
    color: const Color.fromARGB(255, 255, 102, 0),
  ),
  Categories.dairy: Category(
    title: 'Dairy',
    color: Colors.green[400]!,
  ),
  Categories.carbs: Category(
    title: 'Carbs',
    color: const Color.fromARGB(255, 255, 190, 190),
  ),
  Categories.sweets: Category(
    title: 'Sweets',
    color: const Color.fromARGB(255, 255, 0, 100),
  ),
  Categories.spices: Category(
    title: 'Spices',
    color: const Color.fromARGB(255, 255, 200, 080),
  ),
  Categories.convenience: Category(
    title: 'Convenience',
    color: const Color.fromARGB(255, 200, 200, 10),
  ),
  Categories.hygiene: Category(
    title: 'Hygiene',
    color: const Color.fromARGB(255, 200, 90, 150),
  ),
  Categories.other: Category(
    title: 'Other',
    color: Colors.blue[300]!,
  ),
};