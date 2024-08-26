import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recent_dishes_app/src/features/main_screen/domain/main_screen_models.dart';

abstract class DishesApi {
  Future<void> saveDishToDB(Dish dish);

  Future<List<Dish>> loadDishesFromDB();

  Future<void> deleteDishFromDB(Dish dish);
}

class DishesApiFirebase implements DishesApi {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<void> saveDishToDB(Dish dish) async {
    Timestamp timestamp = Timestamp.fromDate(dish.date);
    int numericDishType = dish.dishType == DishType.full ? 0 : 1;
    try {
      db.collection('dishes').doc(timestamp.toString()).set({
        'datetime': timestamp,
        "dishtype": numericDishType
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<Dish>> loadDishesFromDB() async {
    List<Dish> dishes = [];
    try {
      QuerySnapshot<Map<String, dynamic>> data =
          await db.collection("dishes").get();
      for (var docSnapshot in data.docs) {
        Map<String, dynamic> data = docSnapshot.data();
        Timestamp dateTime = data["datetime"];
        DishType type =
            data["dishtype"] == 0 ? DishType.full : DishType.aLittle;
        dishes.add(Dish(
            date: DateTime.fromMillisecondsSinceEpoch(
                dateTime.millisecondsSinceEpoch),
            dishType: type));

      }
    } catch (e) {
      print(e);
    }
    return dishes.reversed.toList();
  }

  @override
  Future<void> deleteDishFromDB(Dish dish) async {
    Timestamp timestamp = Timestamp.fromDate(dish.date);
    db.collection("dishes").doc(timestamp.toString()).delete();
  }
}
