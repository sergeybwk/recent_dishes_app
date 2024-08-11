import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/main_screen_models.dart';

part 'main_screen_events.dart';

part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc()
      : super(MainScreenState(dishes: [], status: MainScreenStatus.loading)) {
    on<AddNewDishEvent>(_addNewDish);
    on<InitMainScreen>(_loadDishesFromDB);
  }

  void _loadDishesFromDB(InitMainScreen event, Emitter<MainScreenState> emit) {
    emit(state.copyWith(newStatus: MainScreenStatus.loadingSuccess));
  }

  void _addNewDish(AddNewDishEvent event, Emitter<MainScreenState> emit) {
    DateTime _currentDateTime = DateTime.now();
    List<Dish> _newDishList = [
      ...state.dishes,
      Dish(date: _currentDateTime, dishType: event.dishType)
    ];
    emit(state.copyWith(
        newDishes: _newDishList, newStatus: MainScreenStatus.loadingSuccess));
    print(state.dishes);
  }
}
