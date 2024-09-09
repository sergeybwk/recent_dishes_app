import 'package:recent_dishes_app/src/common/domain/list_entry_model.dart';

enum DishType {
  aLittle,
  full
}

class Dish implements IListEntry {
  @override
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