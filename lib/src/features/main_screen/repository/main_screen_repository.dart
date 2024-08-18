import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recent_dishes_app/src/features/main_screen/domain/main_screen_models.dart';

abstract class MainScreenRepository {
  Future<void> saveDishToDB(Dish dish);
  Future<List<Dish>> loadDishesFromDB();
}

class MainScreenRepositoryFirebase implements MainScreenRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<void> saveDishToDB(Dish dish) async {
    var timestamp = DateTime.timestamp().toString();
    int numericDishType = dish.dishType == DishType.full ? 0 : 1;
    try {
      db.collection('dishes').doc(timestamp).set({
        'datetime': Timestamp.fromDate(dish.date),
        "dishtype": numericDishType
      });
    }
    catch (e) {
      print(e);
    }
  }

  @override
  Future<List<Dish>> loadDishesFromDB() async {
    print("load dishes from db");
    List<Dish> dishes = [];
    try {
      QuerySnapshot<Map<String, dynamic>> data = await db.collection("dishes").get();
      for (var docSnapshot in data.docs) {
        Map<String, dynamic> data = docSnapshot.data();
        Timestamp dateTime = data["datetime"];
        DishType type = data["dishtype"] == 0 ? DishType.full : DishType.aLittle;
        dishes.add(Dish(date: DateTime.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch), dishType: type));
      }
    }
    catch (e) {
      print(e);
    }
    for (var i in dishes) {
      print("${i.date} ${i.dishType}");
    }
    return dishes;
  }
}
