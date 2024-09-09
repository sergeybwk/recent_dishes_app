import 'package:recent_dishes_app/src/features/water_screen/domain/water_models.dart';

getDailyWaterConsumption(Map<String, List<WaterIntake>> waterIntakes) {
  int consumption = 0;
  DateTime today = DateTime.now();
  if (waterIntakes.containsKey(today.toString().substring(0, 10))) {
    List<WaterIntake> dayWaterIntakes = waterIntakes[today.toString().substring(0, 10)]!;
    for (WaterIntake i in dayWaterIntakes) {
      if (i.date.month == today.month && i.date.day == today.day) {
        consumption += i.volume;
      }
    }
  }
  return consumption;
}
