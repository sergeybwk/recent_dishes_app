enum DishType {
  aLittle,
  full
}

class Dish {
  final DateTime date;
  final DishType? dishType;

  const Dish({required this.date, this.dishType});
}