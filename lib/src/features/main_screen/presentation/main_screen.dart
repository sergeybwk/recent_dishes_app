import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/common/widgets/custom_error_widget.dart';
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
      body: BlocListener<MainScreenBloc, MainScreenState>(
        listener: _listener,
        child: BlocBuilder<MainScreenBloc, MainScreenState>(
          builder: (BuildContext context, MainScreenState state) {
            if (state.status == MainScreenStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TimerWidget(
                            dateTime:
                            state.secondsFromRecentDish ?? DateTime(1970)),
                        const AddNewDish(),
                        const SizedBox(height: 15),
                      ],
                    )),
                Flexible(
                  flex: 2,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch
                        }),
                    // TODO Add group by day
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
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
                      },),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<MainScreenBloc>(
      child: this,
      create: (_) =>
      MainScreenBloc(
          mainScreenRepository: DishesApiFirebase(), ticker: Ticker())
        ..add(InitMainScreen()),
    );
  }

  void _listener(BuildContext context, MainScreenState state) {
    switch (state.status) {
      case MainScreenStatus.loadingFailed:
        showDialog(context: context, builder: (context) {
          return const CustomErrorWidget(
              errorText: "Failed to load recent dishes");
        });
      case MainScreenStatus.addingFailed:
      showDialog(context: context, builder: (context) {
        return const CustomErrorWidget(errorText: "Failed to add new dish");
      });
      case MainScreenStatus.deleteFailed:
        showDialog(context: context, builder: (context) {
          return const CustomErrorWidget(errorText: "Failed to delete dish");
        });
      case _:
    }
  }
}