import 'package:uuid/uuid.dart';
import 'category.dart';

const uuid = Uuid();

class GroceryItem{
  final String id;
  final String name;
  final int quantity;
  final Category category;

  GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category
  });

}