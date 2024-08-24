import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recent_dishes_app/src/features/water_screen/domain/water_models.dart';
import 'package:recent_dishes_app/src/features/water_screen/repository/water_screen_repository.dart';

part 'water_event.dart';

part 'water_state.dart';

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  WaterBloc({required this.waterScreenRepository})
      : super(WaterState(waterIntakes: [], status: WaterStatus.loading)) {
    on<AddWaterEvent>(_addNewWaterIntake);
    on<DeleteWaterEvent>(_deleteWaterIntake);
    on<InitWaterScreen>(_loadWaterIntakes);
  }

  final WaterScreenRepository waterScreenRepository;

  Future<void> _loadWaterIntakes(InitWaterScreen event,
      Emitter<WaterState> emit) async {
    List<WaterIntake>? waterIntakes =
    await waterScreenRepository.loadWaterIntakesFromDB();
    if (waterIntakes != null) {
      emit(state.copyWith(
          newStatus: WaterStatus.loadingSuccess,
          newWaterIntakes: waterIntakes));
    } else {
      emit(state.copyWith(newStatus: WaterStatus.loadingFailed));
    }
  }

  Future<void> _addNewWaterIntake(AddWaterEvent event,
      Emitter<WaterState> emit) async {
    DateTime dateTime = DateTime.timestamp();
    WaterIntake newWaterIntake =
    WaterIntake(volume: event.volume, date: dateTime);
    List<WaterIntake> newWaterIntakesList = [
      newWaterIntake,
      ...state.waterIntakes
    ];
    try {
      waterScreenRepository.addWaterIntakeToDB(event.volume, dateTime);
      emit(state.copyWith(
          newStatus: state.status, newWaterIntakes: newWaterIntakesList));
    } catch (e) {
      print("adding new water intake failed, problem: $e");
      emit(state.copyWith(newStatus: WaterStatus.addingFailed));
    }
  }

  Future<void> _deleteWaterIntake(DeleteWaterEvent event,
      Emitter<WaterState> emit) async {
    List<WaterIntake> newWaterIntakesList = List.from(state.waterIntakes)
      ..removeWhere((element) => element.date == event.date);
    try {
      waterScreenRepository.deleteWaterIntakeFromDB(event.date);
      emit(state.copyWith(newWaterIntakes: newWaterIntakesList));
    }
    catch (e) {
      print("failed to delete the waterIntake from db, reason: $e");
      emit(state.copyWith(newStatus: WaterStatus.deleteFailed));
    }
  }
}