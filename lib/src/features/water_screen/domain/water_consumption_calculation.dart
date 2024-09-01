import 'package:recent_dishes_app/src/features/water_screen/domain/water_models.dart';

class WaterConsumptionCalculation {
  static getDailyWaterConsumption(List<WaterIntake> waterIntakes) {
    int consumption = 0;
    DateTime today = DateTime.now();
    for (WaterIntake i in waterIntakes) {
      if (i.date.month == today.month && i.date.day == today.day) {
        consumption += i.volume;
      }
    }
    return consumption;
  }
}