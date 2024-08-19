import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/features/main_screen/bloc/main_screen_bloc.dart';
import 'package:recent_dishes_app/src/features/main_screen/repository/main_screen_repository.dart';

import '../features/main_navigation/navigation_page.dart';
import '../features/main_screen/presentation/main_screen.dart';
import '../features/water_screen/presentation/water_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: NavigationRoute.page, path: "/", initial: true, children: [
      AutoRoute(page: MainRoute.page, path: "food_screen"),
      AutoRoute(page: WaterRoute.page, path: "water_screen"),
    ])
  ];
}