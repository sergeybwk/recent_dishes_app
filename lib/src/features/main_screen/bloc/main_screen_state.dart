import "../domain/main_screen_models.dart";

class MainScreenEvent {
  const MainScreenEvent();
}

class InitMainScreen extends MainScreenEvent {
  const InitMainScreen();
}

class AddNewDish {
  final DishType? dishType;
  const AddNewDish({this.dishType});
}