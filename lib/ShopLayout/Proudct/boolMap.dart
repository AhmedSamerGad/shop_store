import 'package:flutter/foundation.dart';
import '../Favorite/FavoriteGetModel.dart';

class BoolMapNotifier {
  late ValueNotifier<Map<int, bool>> _mapNotifier;
  late ValueNotifier<List<Data>> _listNotifer;

  BoolMapNotifier(Map<int, bool> initialMap, List<Data> initList) {
    _mapNotifier = ValueNotifier<Map<int, bool>>(initialMap);
    _listNotifer = ValueNotifier<List<Data>>(initList);
  }

  ValueNotifier<Map<int, bool>> get notifier => _mapNotifier;
  ValueNotifier<List<Data>> get notifierList => _listNotifer;

  void updateValue(int key, bool value) {
    final Map<int, bool> updatedMap = Map.from(_mapNotifier.value);
    updatedMap[key] = value;
    _mapNotifier.value = updatedMap;
  }

  void updateListValue(int index, dynamic value) {
    final List<Data> updateList = List.from(_listNotifer.value);
    if (updateList.isNotEmpty) {
      updateList[index] = value;
      _listNotifer.value = updateList;
    }
  }

// You can add other methods to modify the map as needed, such as removing entries, clearing the map, etc.
}
