import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/common/widgets/card_widget.dart';
import 'package:recent_dishes_app/src/common/widgets/custom_error_widget.dart';
import 'package:recent_dishes_app/src/features/water_screen/presentation/widgets/add_water_widget.dart';
import 'package:recent_dishes_app/src/features/water_screen/data/water_api.dart';
import 'package:recent_dishes_app/src/features/water_screen/presentation/widgets/water_cup_widget.dart';

import '../presentation/bloc/water_bloc.dart';

@RoutePage()
class WaterScreen extends StatelessWidget implements AutoRouteWrapper {
  const WaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WaterBloc, WaterState>(
        listener: _blocListener,
        child: BlocBuilder<WaterBloc, WaterState>(builder: (context, state) {
          if (state.status == WaterStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 2,
                    child: WaterCupWidget(waterConsumed: state.dailyWaterConsumption)),
                const Flexible(
                    flex: 1,
                    child: AddWaterWidget()),
                Flexible(
                  flex: 4,
                  child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.mouse,
                            PointerDeviceKind.touch
                          }),
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: state.waterIntakes.length,
                          itemBuilder: (context, index) {
                            String key = state.waterIntakes.keys.elementAt(index);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 50),
                                    child: Text(key.toString())),
                                for (var i in state.waterIntakes[key]!)
                                  CardWidget(
                                      subtitleText: "${i.volume} ml",
                                      onDelete: () {
                                        context
                                            .read<WaterBloc>()
                                            .add(DeleteWaterEvent(date: i.date));
                                      },
                                      date: i.date)
                              ],
                            );
                          })),
                )
              ]);
        }));
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<WaterBloc>(
      child: this,
      create: (_) => WaterBloc(waterScreenRepository: WaterApiFirebase())
        ..add(const InitWaterScreen()),
    );
  }

  void _blocListener(BuildContext context, WaterState state) {
    switch (state.status) {
      case WaterStatus.loadingFailed:
        showDialog(
            context: context,
            builder: (context) {
              return const CustomErrorWidget(
                  errorText: "Failed to load the water intakes");
            });
      case WaterStatus.addingFailed:
        showDialog(
            context: context,
            builder: (context) {
              return const CustomErrorWidget(
                  errorText: "Failed to add new water intake the water intakes");
            });
      case WaterStatus.deleteFailed:
        showDialog(
            context: context,
            builder: (context) {
              return const CustomErrorWidget(
                  errorText: "Failed to delete water intake the water intakes");
            });
      case _:
    }
  }
}
