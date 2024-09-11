import 'dart:ui';

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
                    flex: 2,
                    child: Column(
                      children: [
                        const Spacer(),
                        TimerWidget(
                            dateTime:
                                state.secondsFromRecentDish ?? DateTime(1970)),
                        const Spacer(),
                        const AddNewDish(),
                      ],
                    )),
                Flexible(
                  flex: 4,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch
                        }),
                    child: ListView.builder(
                      itemCount: state.dishes.keys.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        String key = state.dishes.keys.elementAt(index);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50),
                                child: Text(key.toString())),
                            for (var i in state.dishes[key]!)
                              CardWidget(
                                  subtitleText: (i.dishType == DishType.full
                                          ? "Full meal"
                                          : "Snack")
                                      .toString(),
                                  onDelete: () {
                                    context
                                        .read<MainScreenBloc>()
                                        .add(DeleteDishEvent(dish: i));
                                  },
                                  date: i.date)
                          ],
                        );
                      },
                    ),
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
      create: (_) => MainScreenBloc(
          mainScreenRepository: DishesApiFirebase(), ticker: Ticker())
        ..add(const InitMainScreen()),
    );
  }

  void _listener(BuildContext context, MainScreenState state) {
    switch (state.status) {
      case MainScreenStatus.loadingFailed:
        showDialog(
            context: context,
            builder: (context) {
              return const CustomErrorWidget(
                  errorText: "Failed to load recent dishes");
            });
      case MainScreenStatus.addingFailed:
        showDialog(
            context: context,
            builder: (context) {
              return const CustomErrorWidget(
                  errorText: "Failed to add new dish");
            });
      case MainScreenStatus.deleteFailed:
        showDialog(
            context: context,
            builder: (context) {
              return const CustomErrorWidget(
                  errorText: "Failed to delete dish");
            });
      case _:
    }
  }
}
