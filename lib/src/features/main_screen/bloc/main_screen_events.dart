part of 'main_screen_bloc.dart';

class MainScreenEvent {
  const MainScreenEvent();
}

class InitMainScreen extends MainScreenEvent {
  const InitMainScreen();
}

class AddNewDish extends MainScreenEvent{
  final DishType dishType;
  const AddNewDish({required this.dishType});
}