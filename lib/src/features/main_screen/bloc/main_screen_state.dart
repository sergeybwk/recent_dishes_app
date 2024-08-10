part of 'main_screen_bloc.dart';

enum MainScreenStatus {
  loading,
  loadingSuccess
}

class MainScreenState extends Equatable {
  const MainScreenState({required this.dishes});

  final List<Dish> dishes;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  MainScreenState copyWith(List<Dish> newDishes) {
    return MainScreenState(dishes: newDishes ?? dishes);
  }
}