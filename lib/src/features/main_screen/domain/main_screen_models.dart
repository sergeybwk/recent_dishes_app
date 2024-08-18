enum DishType {
  aLittle,
  full
}

class Dish {
  final DateTime date;
  final DishType? dishType;


  Map<String, dynamic> toJson() {
    return {
      "datetime": date,
      "dishtype": {
        if (dishType == null) {
          0
        }
        else
          if (dishType == DishType.full) {
            0
          }
          else
            {
              1
            }
      }
    };
  }

  const Dish({required this.date, this.dishType});
}