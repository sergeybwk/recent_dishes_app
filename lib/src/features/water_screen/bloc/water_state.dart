part of 'water_bloc.dart';

enum WaterStatus { loading, loadingSuccess }

class WaterState {
  const WaterState({required this.waterIntakes, required this.status});

  final List<WaterIntake> waterIntakes;
  final WaterStatus status;

  WaterState copyWith(
      {required newStatus, List<WaterIntake>? newWaterIntakes}) {
    return WaterState(
        waterIntakes: newWaterIntakes ?? waterIntakes, status: status);
  }
}
