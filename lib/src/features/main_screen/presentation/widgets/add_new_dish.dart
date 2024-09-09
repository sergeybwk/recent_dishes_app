import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/features/main_screen/presentation/bloc/main_screen_bloc.dart';
import '../../domain/main_screen_models.dart';

class AddNewDish extends StatefulWidget {
  const AddNewDish({super.key});

  @override
  State<AddNewDish> createState() => _AddNewDishState();
}

class _AddNewDishState extends State<AddNewDish> {
  final List<bool> _selectedDishType = [true, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          children: [Text("Full"), Text("Half")],
          isSelected: _selectedDishType,
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < _selectedDishType.length; i++) {
                _selectedDishType[i] = index == i;
              }
            });
          },
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
            onPressed: () {
              context.read<MainScreenBloc>().add(AddNewDishEvent(
                  dishType: _selectedDishType[0] == true
                      ? DishType.full
                      : DishType.aLittle));
            },
            child: Text("Add new dish"))
      ],
    );
  }
}
