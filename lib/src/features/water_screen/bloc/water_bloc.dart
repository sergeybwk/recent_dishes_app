import 'package:bloc/bloc.dart';
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

  Future<void> _loadWaterIntakes(InitWaterScreen event, Emitter<WaterState> emit) async {
    List<WaterIntake>? waterIntakes = await waterScreenRepository.loadWaterIntakesFromDB();
    if (waterIntakes != null) {
      emit(state.copyWith(newStatus: WaterStatus.loadingSuccess, newWaterIntakes: waterIntakes));
    }
    else {
      emit(state.copyWith(newStatus: WaterStatus.loadingFailed));
    }
  }

  Future<void> _addNewWaterIntake(AddWaterEvent event, Emitter<WaterState> emit) async {

  }

  Future<void> _deleteWaterIntake(DeleteWaterEvent event, Emitter<WaterState> emit) async {

  }

}
