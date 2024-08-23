part of 'water_bloc.dart';

class WaterEvent {
  const WaterEvent();
}

class InitWaterScreen extends WaterEvent {
  const InitWaterScreen();
}

class AddWaterEvent extends WaterEvent {
  final int volume;
  const AddWaterEvent({required this.volume});
}

class DeleteWaterEvent extends WaterEvent {
  final DateTime date;
  const DeleteWaterEvent({required this.date});
}