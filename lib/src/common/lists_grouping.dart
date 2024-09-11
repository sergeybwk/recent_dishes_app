import 'package:collection/collection.dart';
import '../common/domain/list_entry_model.dart';

Map<String, List<T>> groupListByDate<T extends IListEntry>(List<T> list) {
  return groupBy(list, (element) => element.date.toString().substring(0, 10));
}
