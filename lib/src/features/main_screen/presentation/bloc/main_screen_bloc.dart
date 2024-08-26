import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/features/main_screen/data/dishes_api.dart';
import '../../domain/main_screen_models.dart';

part 'main_screen_events.dart';

part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc({required this.mainScreenRepository})
      : super(MainScreenState(dishes: [], status: MainScreenStatus.loading)) {
    on<AddNewDishEvent>(_addNewDish);
    on<InitMainScreen>(_loadDishesFromDB);
    on<DeleteDishEvent>(_deleteDish);
  }


  DishesApi mainScreenRepository;

  Future<void> _loadDishesFromDB(InitMainScreen event,
      Emitter<MainScreenState> emit) async {
    print("load dishes bloc init");
    List<Dish> dishes = await mainScreenRepository.loadDishesFromDB();
    emit(state.copyWith(
        newDishes: dishes, newStatus: MainScreenStatus.loadingSuccess));
  }

  void _addNewDish(AddNewDishEvent event, Emitter<MainScreenState> emit) {
    DateTime _currentDateTime = DateTime.timestamp();
    Dish newDish = Dish(date: _currentDateTime, dishType: event.dishType);
    List<Dish> newDishList = [newDish, ...state.dishes];
    print(newDishList.last.dishType);
    mainScreenRepository.saveDishToDB(newDish);
    emit(state.copyWith(
        newDishes: newDishList, newStatus: MainScreenStatus.loadingSuccess));
    print(state.dishes);
  }

  void _deleteDish(DeleteDishEvent event, Emitter<MainScreenState> emit) {
    mainScreenRepository.deleteDishFromDB(event.dish);
    print(state.dishes.length);
    List<Dish> newDishList = List.of(state.dishes)
      ..removeWhere((element) => element.date == event.dish.date);
    print(state.dishes.length);
    emit(state.copyWith(newDishes: newDishList));
  }
}
