part of 'water_bloc.dart';

enum WaterStatus {
  loading,
  loadingSuccess,
  loadingFailed,
  addingFailed,
  deleteFailed
}

class WaterState extends Equatable {
  const WaterState(
      {required this.waterIntakes,
      required this.status,
      required this.dailyWaterConsumption});

  final List<WaterIntake> waterIntakes;
  final WaterStatus status;
  final int dailyWaterConsumption;

  WaterState copyWith(
      {WaterStatus? newStatus,
      List<WaterIntake>? newWaterIntakes,
      int? newDailyWaterConsumption}) {
    return WaterState(
        waterIntakes: newWaterIntakes ?? waterIntakes,
        status: newStatus ?? status,
        dailyWaterConsumption: newDailyWaterConsumption ?? dailyWaterConsumption);
  }

  @override
  List<Object?> get props => [status, waterIntakes, dailyWaterConsumption];
}
