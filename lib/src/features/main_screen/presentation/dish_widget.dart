import 'package:flutter/material.dart';
import '../domain/main_screen_models.dart';

class DishWidget extends StatelessWidget {
  const DishWidget({super.key, required this.dish});

  final Dish dish;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(dish.date.toString()),
      subtitle: dish.dishType != null ? Text(dish.dishType.toString()) : Text(""),
    );
  }
}
