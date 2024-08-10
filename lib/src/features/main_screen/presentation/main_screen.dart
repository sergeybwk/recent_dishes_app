import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/features/main_screen/presentation/dish_widget.dart';

import '../bloc/main_screen_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainScreenBloc, MainScreenState>(builder: (BuildContext context, MainScreenState state) {
        return Column(
          children: [
            SizedBox(height: 200,),
            Text("00:00:00"),
            ListView.builder(itemBuilder: (_, int index) {
              return DishWidget(dish: state.dishes[index]);
            })
          ],
        );
      },),
    );
  }
}
