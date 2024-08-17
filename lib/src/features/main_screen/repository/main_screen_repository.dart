import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recent_dishes_app/src/features/main_screen/domain/main_screen_models.dart';
import '../../../../firebase_options.dart';

class MainScreenRepository {
  MainScreenRepository() {
    initFirebase();
    db = FirebaseFirestore.instance;
  }

  late FirebaseFirestore db;

  Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> saveDishToDB() async {

  }

  Future<List<Dish>> loadDishesFromDB() async {
    List<Dish> dishes = [];
    db.collection("dishes").get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = docSnapshot.data();
        print(data["datetime"]);
        var type = data["dishtype"] == 0 ? DishType.full : DishType.aLittle;
        print(type);
        dishes.add(Dish(date: data["datetime"], dishType: type));
      }
    });
    for (var i in dishes) {
      print("${i.date} ${i.dishType}");
    }
    return dishes;
  }
}
