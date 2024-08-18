import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../domain/main_screen_models.dart';

class DishWidget extends StatelessWidget {
  const DishWidget({super.key, required this.dish});

  final Dish dish;

  @override
  Widget build(BuildContext context) {
    String dishTypeText = switch (dish.dishType) {
      DishType.full => "Complete dish",
      null => "",
      DishType.aLittle => "Little snack",
    };
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: ListTile(
        title: Text(DateFormat("EEE, dd MMM HH:mm").format(dish.date.toLocal())),
        subtitle: Text(dishTypeText),
      ),
    );
  }
}
