import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:recent_dishes_app/src/features/water_screen/presentation/add_water_widget.dart';

@RoutePage()
class WaterScreen extends StatelessWidget {
  const WaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      AddWaterWidget()
    ],);
  }
}
