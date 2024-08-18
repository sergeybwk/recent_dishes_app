import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recent_dishes_app/src/features/main_screen/bloc/main_screen_bloc.dart';
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
        trailing: IconButton(onPressed: () {
          context.read<MainScreenBloc>().add(DeleteDishEvent(dish: dish));
        }, icon: const Icon(Icons.delete_outline_rounded)),
      ),
    );
  }
}
