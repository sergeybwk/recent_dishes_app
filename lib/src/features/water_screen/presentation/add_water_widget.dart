import 'package:flutter/material.dart';

class AddWaterWidget extends StatefulWidget {
  const AddWaterWidget({super.key});

  @override
  State<AddWaterWidget> createState() => _AddWaterWidgetState();
}

class _AddWaterWidgetState extends State<AddWaterWidget> {
  final List<bool> _selectedWaterVolume = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        isSelected: _selectedWaterVolume,
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < _selectedWaterVolume.length; i++) {
              _selectedWaterVolume[i] = index == i;
            }
          });
    },
        children: const [Text("100 мл"), Text("200 мл"), Text("250 мл")],
    );
  }
}
