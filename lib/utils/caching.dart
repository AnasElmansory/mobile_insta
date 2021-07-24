//* caching
import 'package:hive/hive.dart';

Future<Map<int, List<T>>> getCachedItems<T>() async {
  final box = await Hive.openBox('cachedItems');
  final pageKey = (box.get('pageKey', defaultValue: 1) ?? 1) as int;
  final itemsList = box.get(T.toString()) ?? <T>[];
  final items = List<T>.from(itemsList);
  return {pageKey: items};
}

Future<void> setCachedItems<T>(int? pageKey, List<T> _items) async {
  final box = await Hive.openBox('cachedItems');
  final itemsList = box.get(T.toString());
  final items = itemsList == null ? <T>[] : List<T>.from(itemsList);
  for (var item in _items) {
    if (!items.contains(item)) {
      items.add(item);
    }
  }
  await box.put('pageKey', pageKey);
  await box.put(T.toString(), items);
}

Future<void> setNamedCachedItems<T>(String namedKey, List<T> _items) async {
  final box = await Hive.openBox('cachedItems');
  final itemsList = box.get(namedKey);
  final items = itemsList == null ? <T>[] : List<T>.from(itemsList);
  for (var item in _items) {
    if (!items.contains(item)) {
      items.add(item);
    }
  }
  await box.put(T.toString(), items);
}

Future<List<T>> getNamedCachedItems<T>(String namedKey) async {
  final box = await Hive.openBox('cachedItems');
  final itemsList = box.get(namedKey) ?? <T>[];
  final items = List<T>.from(itemsList);
  return items;
}
