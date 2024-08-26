part of 'water_bloc.dart';

enum WaterStatus {
  loading,
  loadingSuccess,
  loadingFailed,
  addingFailed,
  deleteFailed
}

class WaterState extends Equatable {
  const WaterState({required this.waterIntakes, required this.status});

  final List<WaterIntake> waterIntakes;
  final WaterStatus status;

  WaterState copyWith(
      {WaterStatus? newStatus, List<WaterIntake>? newWaterIntakes}) {
    return WaterState(
        waterIntakes: newWaterIntakes ?? waterIntakes,
        status: newStatus ?? status);
  }

  @override
  List<Object?> get props => [status, waterIntakes];
}
