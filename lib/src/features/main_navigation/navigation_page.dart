import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recent_dishes_app/src/utils/router.dart';

@RoutePage()
class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        MainRoute(),
        WaterRoute()
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.food_bank_rounded), label: "Еда"),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop_rounded), label: "Вода")
        ],
        currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,);
      },
    );
  }
}
