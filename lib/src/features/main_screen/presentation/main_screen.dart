import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/features/main_screen/domain/ticker.dart';
import 'package:recent_dishes_app/src/features/main_screen/presentation/widgets/add_new_dish.dart';
import 'package:recent_dishes_app/src/common/widgets/card_widget.dart';
import 'package:recent_dishes_app/src/features/main_screen/data/dishes_api.dart';
import 'package:recent_dishes_app/src/features/main_screen/presentation/widgets/timer_widget.dart';

import '../presentation/bloc/main_screen_bloc.dart';
import '../domain/main_screen_models.dart';

@RoutePage()
class MainScreen extends StatelessWidget implements AutoRouteWrapper {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (BuildContext context, MainScreenState state) {
          if (state.status == MainScreenStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              TimerWidget(dateTime: state.secondsFromRecentDish ?? DateTime(1970)),
              const AddNewDish(),
              const SizedBox(height: 15),
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.touch
                      }),
                  // TODO Add group by day
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.dishes.length,
                      itemBuilder: (_, int index) {
                        final subtitleText =
                            switch (state.dishes[index].dishType) {
                          DishType.full => "Complete dish",
                          null => "",
                          DishType.aLittle => "Little snack",
                        };
                        return CardWidget(
                          onDelete: () {
                            context.read<MainScreenBloc>().add(
                                DeleteDishEvent(dish: state.dishes[index]));
                          },
                          date: state.dishes[index].date,
                          subtitleText: subtitleText,
                        );
                      }),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<MainScreenBloc>(
      child: this,
      create: (_) =>
          MainScreenBloc(mainScreenRepository: DishesApiFirebase(), ticker: Ticker())
            ..add(InitMainScreen()),
    );
  }
}
