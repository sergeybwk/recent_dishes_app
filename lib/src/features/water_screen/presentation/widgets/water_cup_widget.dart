import 'package:flutter/material.dart';

class WaterCupWidget extends StatelessWidget {
  const WaterCupWidget({super.key, required this.waterConsumed});

  final int waterConsumed;

  @override
  Widget build(BuildContext context) {
    print("test ${(waterConsumed / 2000) * 200}");
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Container(
        height: 150,
        width: 115,
        decoration: BoxDecoration(
          color: Colors.transparent,
            border: Border.all(color: Colors.black12),),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 115,
            height: (waterConsumed / 2000) * 150,
              child: DecoratedBox(decoration: BoxDecoration(
                color: Colors.lightBlue,
              ))),
        ),
      ),
    );
  }
}
