import 'package:hive/hive.dart';

// Кэш, сохраняемый на устройстве
class HiveService {

  Future<void> addAllToBox<T>(List<T> items, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    for (var item in items) {
      openBox.add(item);
    }
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