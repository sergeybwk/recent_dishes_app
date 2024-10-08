import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recent_dishes_app/src/features/main_screen/data/dishes_api.dart';
import 'package:recent_dishes_app/src/features/main_screen/domain/time_calculations.dart';
import '../../domain/main_screen_models.dart';
import '../../domain/ticker.dart';
import '../../../../common/lists_grouping.dart';

part 'main_screen_events.dart';

part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc({required this.mainScreenRepository, required Ticker ticker})
      : _ticker = ticker,
        super(MainScreenState(dishes: {}, status: MainScreenStatus.loading)) {
    on<AddNewDishEvent>(_addNewDish);
    on<InitMainScreen>(_loadDishesFromDB);
    on<DeleteDishEvent>(_deleteDish);
    on<_TimerTicked>(_onTicked);
  }

  final Ticker _ticker;
  final DishesApi mainScreenRepository;
  StreamSubscription<int>? _tickerSubscription;

  Future<void> _loadDishesFromDB(
      InitMainScreen event, Emitter<MainScreenState> emit) async {
    List<Dish> dishesList = await mainScreenRepository.loadDishesFromDB();
    Map<String, List<Dish>> newDishes = groupListByDate(dishesList);
    int timeDifference = TimeCalculations.getTimeDifferenceInSeconds(
        DateTime.now(), dishesList.first.date);
    print(newDishes);
    // TODO Add checker if recent dish was more than 24 hours ago
    emit(state.copyWith(
        newDishes: newDishes,
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
            state.secondsFromRecentDish!.add(const Duration(seconds: 1))));
  }

  void _addNewDish(AddNewDishEvent event, Emitter<MainScreenState> emit) async {
    DateTime currentDateTime = DateTime.timestamp();
    Dish newDish = Dish(date: currentDateTime, dishType: event.dishType);
    // Check if the state.dishes.last (today) == DateTime.now().day or just use groupListByDay with newDishList below
    List<Dish> newDishList = [];
    newDishList.add(newDish);
    state.dishes.forEach((_, dishes) {
      newDishList.addAll(dishes);
    });
    Map<String, List<Dish>> newDishMap = groupListByDate(newDishList);
    // newDishMap.forEach((k, v) => v.forEach((e) => print(e.date)));
    try {
      await mainScreenRepository.saveDishToDB(newDish);
      emit(state.copyWith(
          newDishes: newDishMap,
          newStatus: MainScreenStatus.loadingSuccess,
          newSecondsFromRecentDish: DateTime.fromMillisecondsSinceEpoch(
              0)));
    } catch (e) {
      emit(state.copyWith(newStatus: MainScreenStatus.addingFailed));
    }
  }

  void _deleteDish(DeleteDishEvent event, Emitter<MainScreenState> emit) {
    Map<String, List<Dish>> newDishMap = Map.of(state.dishes);
    List<Dish>? dateListDishes =
        newDishMap[event.dish.date.toString().substring(0, 10)];
    dateListDishes?.removeWhere((element) => element.date == event.dish.date);
    removeEmptyMapKeys<Dish>(newDishMap);
    emit(state.copyWith(newDishes: newDishMap));
    try {
      mainScreenRepository.deleteDishFromDB(event.dish);
    } catch (e) {
      print('deleting failed');
      emit(state.copyWith(newStatus: MainScreenStatus.deleteFailed));
      add(const InitMainScreen());
    }
  }
}
