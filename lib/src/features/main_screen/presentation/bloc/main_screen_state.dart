part of 'main_screen_bloc.dart';

enum MainScreenStatus {
  loading,
  loadingSuccess,
  loadingFailed,
  addingFailed,
  deleteFailed
}

class MainScreenState extends Equatable {
  const MainScreenState(
      {required this.dishes, required this.status, this.secondsFromRecentDish});

  final Map<String, List<Dish>> dishes;
  final MainScreenStatus status;
  final DateTime? secondsFromRecentDish;

  @override
  List<Object?> get props => [dishes, status, secondsFromRecentDish];

  MainScreenState copyWith(
      {Map<String, List<Dish>>? newDishes,
      MainScreenStatus? newStatus,
      DateTime? newSecondsFromRecentDish}) {
    return MainScreenState(
        dishes: newDishes ?? dishes,
        status: newStatus ?? status,
        secondsFromRecentDish:
            newSecondsFromRecentDish ?? secondsFromRecentDish);
  }
}
