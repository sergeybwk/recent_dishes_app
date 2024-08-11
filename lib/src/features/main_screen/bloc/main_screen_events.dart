part of 'main_screen_bloc.dart';

class MainScreenEvent {
  const MainScreenEvent();
}

class InitMainScreen extends MainScreenEvent {
  const InitMainScreen();
}

class AddNewDishEvent extends MainScreenEvent{
  final DishType dishType;
  const AddNewDishEvent({required this.dishType});
}