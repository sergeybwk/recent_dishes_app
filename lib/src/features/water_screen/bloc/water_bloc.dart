import 'package:bloc/bloc.dart';
import 'package:recent_dishes_app/src/features/water_screen/domain/water_models.dart';

part 'water_event.dart';

part 'water_state.dart';

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  WaterBloc()
      : super(WaterState(waterIntakes: [], status: WaterStatus.loading)) {
    on<AddWaterEvent>(_addNewWaterIntake);
    on<DeleteWaterEvent>(_deleteWaterIntake);
    on<InitWaterScreen>(_loadWaterIntakes);
  }

  Future<void> _loadWaterIntakes(InitWaterScreen event, Emitter<WaterState> emit) async {

  }

  Future<void> _addNewWaterIntake(AddWaterEvent event, Emitter<WaterState> emit) async {

  }

  Future<void> _deleteWaterIntake(DeleteWaterEvent event, Emitter<WaterState> emit) async {

  }

}
