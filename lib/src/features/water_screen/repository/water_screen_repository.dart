import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recent_dishes_app/src/features/water_screen/domain/water_models.dart';

abstract class WaterScreenRepository {
  Future<void> addWaterIntakeToDB(int volume, DateTime date);

  Future<void> deleteWaterIntakeFromDB(DateTime date);

  Future<List<WaterIntake>?> loadWaterIntakesFromDB();
}

class WaterScreenRepositoryFirebase implements WaterScreenRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<void> addWaterIntakeToDB(int volume, DateTime date) async {
    Timestamp timestamp = Timestamp.fromDate(date);
    try {
      db
          .collection("water")
          .doc(timestamp.toString())
          .set({'date': timestamp, 'volume': volume});
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteWaterIntakeFromDB(DateTime date) async {
    DateTime timestamp = date.toUtc();
    try {
      db.collection('water').doc(timestamp.toString()).delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<WaterIntake>?> loadWaterIntakesFromDB() async {
    List<WaterIntake> waterIntakes = [];
    try {
      QuerySnapshot<Map<String, dynamic>> data =
          await db.collection("water").get();
      for (var docSnapshot in data.docs) {
        Map<String, dynamic> data = docSnapshot.data();
        Timestamp dateTime = data["date"];
        waterIntakes.add(WaterIntake(
            volume: data['volume'],
            date: DateTime.fromMillisecondsSinceEpoch(
                dateTime.millisecondsSinceEpoch)));
      }
    } catch (e) {
      print(e);
      return null;
    }
    return waterIntakes;
  }
}
