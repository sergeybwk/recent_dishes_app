import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/features/main_screen/repository/main_screen_repository.dart';
import '../domain/main_screen_models.dart';

part 'main_screen_events.dart';

part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc({required this.mainScreenRepository})
      : super(MainScreenState(dishes: [], status: MainScreenStatus.loading)) {
    on<AddNewDishEvent>(_addNewDish);
    on<InitMainScreen>(_loadDishesFromDB);
  }

  MainScreenRepository mainScreenRepository;

  Future<void> _loadDishesFromDB(InitMainScreen event, Emitter<MainScreenState> emit) async {
    List<Dish> dishes = await mainScreenRepository.loadDishesFromDB();
    emit(state.copyWith(newDishes: dishes,newStatus: MainScreenStatus.loadingSuccess));
  }

  void _addNewDish(AddNewDishEvent event, Emitter<MainScreenState> emit) {
    DateTime _currentDateTime = DateTime.timestamp();
    List<Dish> _newDishList = [
      ...state.dishes,
      Dish(date: _currentDateTime, dishType: event.dishType)
    ];
    emit(state.copyWith(
        newDishes: _newDishList, newStatus: MainScreenStatus.loadingSuccess));
    print(state.dishes);
  }
}
