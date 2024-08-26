import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/common/widgets/card_widget.dart';
import 'package:recent_dishes_app/src/common/widgets/custom_error_widget.dart';
import 'package:recent_dishes_app/src/features/water_screen/presentation/add_water_widget.dart';
import 'package:recent_dishes_app/src/features/water_screen/data/water_api.dart';

import '../presentation/bloc/water_bloc.dart';

@RoutePage()
class WaterScreen extends StatelessWidget implements AutoRouteWrapper {
  const WaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WaterBloc, WaterState>(
      listener: _blocListener,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AddWaterWidget(),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch
              }),
              child:
                  BlocBuilder<WaterBloc, WaterState>(builder: (context, state) {
                if (state.status == WaterStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.waterIntakes.length,
                    itemBuilder: (context, index) {
                      return CardWidget(
                          date: state.waterIntakes[index].date,
                          subtitleText:
                              "${state.waterIntakes[index].volume} ml",
                          onDelete: () {
                            context.read<WaterBloc>().add(DeleteWaterEvent(
                                date: state.waterIntakes[index].date));
                          });
                    });
              }),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<WaterBloc>(
      child: this,
      create: (_) =>
          WaterBloc(waterScreenRepository: WaterApiFirebase())
            ..add(const InitWaterScreen()),
    );
  }

  void _blocListener(BuildContext context, WaterState state) {
    if (state.status == WaterStatus.loadingFailed) {
      showDialog(
          context: context,
          builder: (context) {
            return const CustomErrorWidget(
                errorText: "Failed to load the water intakes");
          });
    }
  }
}
