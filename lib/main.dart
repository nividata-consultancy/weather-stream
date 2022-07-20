import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_stream/data/prefrences/shared_preference.dart';
import 'package:weather_stream/theme/theme_constants.dart';
import 'package:weather_stream/theme/theme_manager.dart';
import 'package:weather_stream/view/home/home_view.dart';
import 'package:weather_stream/view/splash_screen/splashscreen_view.dart';
import 'package:weather_stream/view/location/location_view.dart';
import 'data/model/locationscreen_arguments.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final SharedPreference sharedPreferenceHelper =
      SharedPreference(sharedPreferences: prefs);
  ThemeManager _themeManager =
      ThemeManager(sharedPreferencesHelper: sharedPreferenceHelper);
  runApp(MyApp(
    sharedPreferenceHelper: sharedPreferenceHelper,
    themeManager: _themeManager,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreference sharedPreferenceHelper;
  final ThemeManager themeManager;
  const MyApp(
      {required this.sharedPreferenceHelper,
      Key? key,
      required this.themeManager})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: themeManager,
      child: MainView(
        sharedPreferenceHelper: sharedPreferenceHelper,
      ),
    );
  }
}

class MainView extends StatelessWidget {
  final SharedPreference sharedPreferenceHelper;

  const MainView({required this.sharedPreferenceHelper, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeMode = context.watch<ThemeManager>().themeMode;
    return MaterialApp(
      title: 'Weather Forecast',
      initialRoute: '/',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) {
            return const SplashScreenView();
          });
        } else if (settings.name == '/second') {
          return MaterialPageRoute(builder: (context) {
            return const LocationView();
          });
        } else if (settings.name == HomeView.routeName) {
          final args = settings.arguments as LocationScreenArguments;
          return MaterialPageRoute(
            builder: (context) {
              return HomeView(
                sharedPreferenceHelper: sharedPreferenceHelper,
                lat: args.lat,
                lon: args.lon,
                searched: args.searched,
              );
            },
          );
        } else {
          return MaterialPageRoute(builder: (context) {
            return const Text('No reroute match');
          });
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
