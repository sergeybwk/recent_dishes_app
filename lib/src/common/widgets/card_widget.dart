import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recent_dishes_app/src/features/main_screen/bloc/main_screen_bloc.dart';
import '../../features/main_screen/domain/main_screen_models.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.subtitleText,
      required this.onDelete,
      required this.date});

  final DateTime date;
  final String subtitleText;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title:
            Text(DateFormat("EEE, dd MMM HH:mm").format(date.toLocal())),
        subtitle: Text(subtitleText),
        trailing: IconButton(
            onPressed: onDelete as void Function()?,
            icon: const Icon(Icons.delete_outline_rounded)),
      ),
    );
  }
}
