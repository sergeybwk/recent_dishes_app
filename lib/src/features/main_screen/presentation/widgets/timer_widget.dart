import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key, required this.dateTime});

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat.Hms().format(dateTime.toUtc()),
      style: const TextStyle(fontSize: 32),
    );
  }
}
