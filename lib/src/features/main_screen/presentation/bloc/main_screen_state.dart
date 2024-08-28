part of 'main_screen_bloc.dart';

enum MainScreenStatus { loading, loadingSuccess }

class MainScreenState extends Equatable {
  const MainScreenState(
      {required this.dishes, required this.status, this.secondsFromRecentDish});

  final List<Dish> dishes;
  final MainScreenStatus status;
  final DateTime? secondsFromRecentDish;

  @override
  // TODO: implement props
  List<Object?> get props => [dishes, status, secondsFromRecentDish];

  MainScreenState copyWith(
      {List<Dish>? newDishes,
      MainScreenStatus? newStatus,
      DateTime? newSecondsFromRecentDish}) {
    return MainScreenState(
        dishes: newDishes ?? dishes,
        status: newStatus ?? status,
        secondsFromRecentDish: newSecondsFromRecentDish ?? secondsFromRecentDish);
  }
}
