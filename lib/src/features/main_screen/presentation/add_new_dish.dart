import 'package:flutter/material.dart';

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
        ToggleButtons(children: [
          Text("Full"),
          Text("Half")
        ], isSelected: _selectedDishType, onPressed: (int index) {
          setState(() {
            for (int i = 0; i < _selectedDishType.length; i++) {
              _selectedDishType[i] = index == i;
            }
          });
        },),
        ElevatedButton(onPressed: () {}, child: Text("add"))
      ],
    );
  }
}
