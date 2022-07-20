import 'package:flutter/material.dart';
import '../data/prefrences/shared_preference.dart';

class ThemeManager with ChangeNotifier {
  final _kThemePreference = "theme_preference";
  late ThemeMode themeMode;
  final SharedPreference sharedPreferencesHelper;
  ThemeManager({required this.sharedPreferencesHelper}) {
    _loadTheme();
  }
  void _loadTheme() {
    int preferredTheme =
        sharedPreferencesHelper.getInt(_kThemePreference, defValue: 1);
    ThemeMode data = ThemeMode.values[preferredTheme];
    themeMode = data;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
    sharedPreferencesHelper.putInt(
        _kThemePreference, ThemeMode.values.indexOf(themeMode));
  }
}
