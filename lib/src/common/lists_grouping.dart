import 'package:collection/collection.dart';
import '../common/domain/list_entry_model.dart';

Map<String, List<T>> groupListByDate<T extends IListEntry>(List<T> list) {
  return groupBy(list, (element) => element.date.toString().substring(0, 10));
}

void removeEmptyMapKeys<T>(Map<String, List<T>> map) {
  map.removeWhere((k, v) => v.isEmpty);
}