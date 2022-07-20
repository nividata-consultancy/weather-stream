import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:weather_stream/data/model/drawerhistory.dart';

class SharedPreference {
  final SharedPreferences sharedPreferences;
  static const historyList = "history_list";

  SharedPreference({required this.sharedPreferences});

  Future<void> addPlace(DrawerHistory history) {
    var list = getPlaceList();
    if (!list.contains(history)) {
      list.add(history);
      return sharedPreferences.setString(
          historyList, jsonEncode(list.map((e) => e.toJson()).toList()));
    } else {
      return Future.value();
    }
  }

  Future<List<String>?> retrieveStringListValue() async {
    var list = sharedPreferences.getStringList(historyList);
    return list;
  }

  Future<void> clearSingleCity(DrawerHistory history) {
    var list = getPlaceList();
    list.remove(history);
    return sharedPreferences.setString(
        historyList, jsonEncode(list.map((e) => e.toJson()).toList()));
  }

  Future<void> clearPlaceList() {
    return sharedPreferences.setString(historyList, jsonEncode([]));
  }

  Future<void> updatedTemp(DrawerHistory history) {
    var list = getPlaceList();
    list.remove(history);
    return sharedPreferences.setString(
        historyList, jsonEncode(list.map((e) => e.toJson()).toList()));
  }

  List<DrawerHistory> getPlaceList() {
    var list = sharedPreferences.getString(historyList);
    if (list == null) {
      return <DrawerHistory>[];
    } else {
      return (jsonDecode(list) as List<dynamic>)
          .map((e) => DrawerHistory.fromJson(e))
          .toList();
    }
  }

  int getInt(String key, {int defValue = -1}) {
    return sharedPreferences.getInt(key) ?? defValue;
  }

  Future<bool> putInt(String key, int value) {
    return sharedPreferences.setInt(key, value);
  }
}
