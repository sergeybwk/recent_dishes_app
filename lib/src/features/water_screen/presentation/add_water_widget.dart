import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/features/water_screen/presentation/bloc/water_bloc.dart';

class AddWaterWidget extends StatefulWidget {
  const AddWaterWidget({super.key});

  @override
  State<AddWaterWidget> createState() => _AddWaterWidgetState();
}

class _AddWaterWidgetState extends State<AddWaterWidget> {
  final List<bool> _selectedWaterVolume = [false, false, false];

  final List<int> _volumesList = [100, 200, 250];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Объем"),
            const SizedBox(
              width: 10,
            ),
            ToggleButtons(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              isSelected: _selectedWaterVolume,
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < _selectedWaterVolume.length; i++) {
                    _selectedWaterVolume[i] = index == i;
                  }
                });
              },
              children: [
                Text(_volumesList[0].toString()),
                Text(_volumesList[1].toString()),
                Text(_volumesList[2].toString())
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
            onPressed: () {
              int index =
                  _selectedWaterVolume.indexWhere((element) => element == true);
              context
                  .read<WaterBloc>()
                  .add(AddWaterEvent(volume: _volumesList[index]));
            },
            child: const Text("Добавить"))
      ],
    );
  }
}
