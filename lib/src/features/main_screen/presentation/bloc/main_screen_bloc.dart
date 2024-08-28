import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/features/main_screen/data/dishes_api.dart';
import 'package:recent_dishes_app/src/features/main_screen/domain/time_calculations.dart';
import '../../domain/main_screen_models.dart';
import '../../domain/ticker.dart';

part 'main_screen_events.dart';

part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc({required this.mainScreenRepository, required Ticker ticker})
      : _ticker = ticker,
        super(MainScreenState(dishes: [], status: MainScreenStatus.loading)) {
    on<AddNewDishEvent>(_addNewDish);
    on<InitMainScreen>(_loadDishesFromDB);
    on<DeleteDishEvent>(_deleteDish);
    on<_TimerTicked>(_onTicked);
  }

  Ticker _ticker;
  DishesApi mainScreenRepository;
  StreamSubscription<int>? _tickerSubscription;

  Future<void> _loadDishesFromDB(
      InitMainScreen event, Emitter<MainScreenState> emit) async {
    print("load dishes bloc init");
    List<Dish> dishes = await mainScreenRepository.loadDishesFromDB();
    print('before time calc');
    int timeDifference = TimeCalculations.getTimeDifferenceInSeconds(
        DateTime.now(), dishes.first.date);
    print('after time calc');
    // TODO Add checker if recent dish was more than 24 hours ago
    emit(state.copyWith(
        newDishes: dishes,
        newStatus: MainScreenStatus.loadingSuccess,
        newSecondsFromRecentDish:
            DateTime.fromMillisecondsSinceEpoch(timeDifference)));
    _tickerSubscription = _ticker.tick().listen((_) {
      add(const _TimerTicked());
    });
  }

  void _onTicked(_TimerTicked event, Emitter<MainScreenState> emit) {
    emit(state.copyWith(
        newSecondsFromRecentDish:
            state.secondsFromRecentDish!.add(Duration(seconds: 1))));
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
