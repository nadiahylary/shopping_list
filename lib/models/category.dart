import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
enum Categories { vegetables, fruit, meat, dairy, carbs, sweets, spices, convenience, hygiene, other }

class Category{
  final String id;
  final String title;
  final Color color;

  Category({
    required this.title,
    required this.color
  }): id = uuid.v4();

}