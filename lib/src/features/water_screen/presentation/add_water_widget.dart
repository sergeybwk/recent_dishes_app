import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/features/water_screen/presentation/bloc/water_bloc.dart';
import 'package:flutter/services.dart';

class AddWaterWidget extends StatefulWidget {
  const AddWaterWidget({super.key});

  @override
  State<AddWaterWidget> createState() => _AddWaterWidgetState();
}

class _AddWaterWidgetState extends State<AddWaterWidget> {
  final List<bool> _selectedWaterVolume = [false, false, false];

  final List<int> _volumesList = [100, 200, 250];

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Объем"),
            const SizedBox(
              width: 10,
            ),
            ToggleButtons(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
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
            SizedBox(
              width: 50,
              child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp(r"\d"), allow: true)
                  ],
                  decoration: InputDecoration(
                    // focusColor: ToggleButtonsTheme.of(context).hoverColor,
                    // fillColor: ToggleButtonsTheme.of(context).hoverColor,
                    // hoverColor: ToggleButtonsTheme.of(context).hoverColor,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                      )),
                  controller: _textController,
                  keyboardType: TextInputType.number),
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
              if (_textController.text.isNotEmpty) {
                context.read<WaterBloc>().add(
                    AddWaterEvent(volume: int.parse(_textController.text)));
                _textController.clear();
              } else if (index != -1) {
                context
                    .read<WaterBloc>()
                    .add(AddWaterEvent(volume: _volumesList[index]));
              }
            },
            child: const Text("Добавить"))
      ],
    );
  }
}
