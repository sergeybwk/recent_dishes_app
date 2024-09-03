import 'package:flutter/material.dart';

class WaterCupWidget extends StatelessWidget {
  const WaterCupWidget({super.key, required this.waterConsumed});

  final int waterConsumed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 115,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: Colors.transparent,
        border: Border.all(color: Colors.black38),
      ),
      child: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
              width: 115,
              height: (waterConsumed / 2000) * 150,
              child: const DecoratedBox(
                  decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.lightBlue,
              ))),
        ),
        Center(
          child: Text(
            "${(waterConsumed / 2000 * 100).round()}%",
            style: TextStyle(fontSize: 18, color: waterConsumed >= 1100 ? Colors.white : Colors.black ),
          ),
        ),
      ]),
    );
  }
}
