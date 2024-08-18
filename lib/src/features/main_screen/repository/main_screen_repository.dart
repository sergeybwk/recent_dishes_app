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
    // db.collection("dishes").add()
  }

  @override
  Future<List<Dish>> loadDishesFromDB() async {
    print("load dishes from db");
    List<Dish> dishes = [];
    QuerySnapshot<Map<String, dynamic>> data = await db.collection("dishes").get();
    for (var docSnapshot in data.docs) {
      Map<String, dynamic> data = docSnapshot.data();
      Timestamp dateTime = data["datetime"];
      DishType type = data["dishtype"] == 0 ? DishType.full : DishType.aLittle;
      dishes.add(Dish(date: DateTime.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch), dishType: type));
    }
    for (var i in dishes) {
      print("${i.date} ${i.dishType}");
    }
    return dishes;
  }
}
