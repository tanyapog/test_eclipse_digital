import 'package:hive/hive.dart';

// Кэш, сохраняемый на устройстве
class HiveService {

  Future<void> putToBox<T>(String key, T item, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    return openBox.put(key, item);
  }

  Future<void> addAllToBox<T>(List<T> items, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    for (var item in items) {
      openBox.add(item);
    }
  }

  Future<T> getFromBox<T>(String key, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    return openBox.get(key);
  }

  Future<List<T>> getAllFromBox<T>(String boxName) async {
    var boxList = <T>[];
    final openBox = await Hive.openBox(boxName);
    for(int i = 0; i < openBox.length; i++) {
      boxList.add(openBox.getAt(i));
    }
    return boxList;
  }
}