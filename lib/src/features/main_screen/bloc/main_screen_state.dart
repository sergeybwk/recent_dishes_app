part of 'main_screen_bloc.dart';

enum MainScreenStatus { loading, loadingSuccess }

class MainScreenState extends Equatable {
  const MainScreenState({required this.dishes, required this.status});

  final List<Dish> dishes;
  final MainScreenStatus status;

  @override
  // TODO: implement props
  List<Object?> get props => [];

  MainScreenState copyWith(
      {List<Dish>? newDishes, MainScreenStatus? newStatus}) {
    return MainScreenState(
        dishes: newDishes ?? dishes, status: newStatus ?? status);
  }
}
