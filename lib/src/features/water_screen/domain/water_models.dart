import 'package:recent_dishes_app/src/common/domain/list_entry_model.dart';

class WaterIntake implements IListEntry {
  const WaterIntake({required this.volume, required this.date});
  final int volume;
  @override
  final DateTime date;
}