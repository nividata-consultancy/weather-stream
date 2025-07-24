import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_stream/data/model/cityweather_detail.dart';
import 'package:weather_stream/data/model/drawerhistory.dart';
import 'package:weather_stream/view/home/bottombarcard_view.dart';
import 'package:weather_stream/view/home/citytime_view.dart';
import 'package:weather_stream/view/home/menu_drawer.dart';
import 'package:weather_stream/view/home/citysky_view.dart';
import 'package:weather_stream/view/home/setting_drawer.dart';
import '../../data/api/api_helper.dart';
import '../../data/model/forecastweather.dart';
import 'package:intl/intl.dart';
import '../../data/prefrences/shared_preference.dart';
import '../../theme/fontsize.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
ApiHelper api = ApiHelper();
final DateFormat formatter = DateFormat('yyyy-MM-dd');

int parseDateStamp(int value) {
  var date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
  int d12 = int.parse(DateFormat('dd').format(date));

  return d12;
}

int parseDateStamp2(String value) {
  int result = int.parse(
      DateFormat('dd ').format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(value)));

  return result;
}

class HomeView extends StatefulWidget {
  final SharedPreference sharedPreferenceHelper;
  final bool searched;
  final double lat;
  final double lon;

  const HomeView({
    required this.sharedPreferenceHelper,
    required this.lon,
    required this.lat,
    required this.searched,
    Key? key,
  }) : super(key: key);

  static const routeName = '/passArguments';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<dynamic> post;
  final myController = TextEditingController();
  late bool tempStatus;
  late bool airStatus;
  late bool speedStatus;
  late double latitude;
  late double longitude;
  late double current;
  CityWeather? cityList;
  ForecastWeather? forestList;
  // late String currentDate;
  late int todayLength;

  late double maxTemp;
  late double minTemp;
  void cityWeatherCalling(double value1, double value2) async {
    setState(() {
      cityList = null;
      forestList = null;
    });
    var x = await api.requestCityWeather(value1, value2);
    var y = await api.getForecast(value1, value2);
    var min = y.weatherList
        .take(8)
        .map((e) => e.main.tempMin)
        .reduce((value, element) => (value > element) ? element : value);

    var max = y.weatherList
        .take(8)
        .map((e) => e.main.tempMax)
        .reduce((value, element) => (value < element) ? element : value);

    setState(() {
      cityList = x;
      forestList = y;
      current = value1;
      minTemp = min.toDouble();
      maxTemp = max.toDouble();
    });

    await widget.sharedPreferenceHelper.addPlace(DrawerHistory(
      name: x.name,
      lat: x.cord.lat,
      lon: x.cord.lon,
      country: x.sys.country,
      temp: x.main.temp.toDouble(),
      imageUrl: x.cityWeather.first.icon,
    ));
  }

  Future<void> clearSearch() async {
    setState(() {
      cityList = null;
    });

    await widget.sharedPreferenceHelper.clearPlaceList();

    var x = await api.requestCityWeather(widget.lat, widget.lon);
    setState(() {
      cityList = x;
    });
    setState(() {
      forestList = null;
    });
    var y = await api.getForecast(widget.lat, widget.lon);
    setState(() {
      forestList = y;
    });
    await widget.sharedPreferenceHelper.addPlace(DrawerHistory(
      name: x.name,
      lat: x.cord.lat,
      lon: x.cord.lon,
      country: x.sys.country,
      temp: x.main.temp.toDouble(),
      imageUrl: x.cityWeather.first.icon,
    ));
  }

  Future<void> deleteSingleData(DrawerHistory history) async {
    if (history.lat.toInt() == current.toInt()) {
      setState(() {
        cityList = null;
        forestList = null;
      });

      await widget.sharedPreferenceHelper.clearSingleCity(history);

      var x = await api.requestCityWeather(widget.lat, widget.lon);
      setState(() {
        cityList = x;
      });
      var y = await api.getForecast(widget.lat, widget.lon);
      setState(() {
        forestList = y;
      });

      await widget.sharedPreferenceHelper.addPlace(DrawerHistory(
        name: x.name,
        lat: x.cord.lat,
        lon: x.cord.lon,
        country: x.sys.country,
        temp: x.main.temp.toDouble(),
        imageUrl: x.cityWeather.first.icon,
      ));
    } else {
      await widget.sharedPreferenceHelper.clearSingleCity(history);
    }
  }

  void refreshDrawerData() async {
    await widget.sharedPreferenceHelper.clearPlaceList();
    var listApi = await api
        .apiCallingByName(widget.sharedPreferenceHelper.getPlaceList());
    listApi.map((e) => widget.sharedPreferenceHelper.addPlace(e));
  }

  @override
  void initState() {
    super.initState();
    tempStatus = false;
    speedStatus = false;
    airStatus = true;
    current = widget.lat;
    latitude = widget.lat;
    longitude = widget.lon;
    todayLength = 0;
    maxTemp = 0;
    minTemp = 0;
    cityWeatherCalling(widget.lat, widget.lon);
    refreshDrawerData();
  }

  Future<bool> _willPopCallback() async {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return (cityList == null)
        ? WillPopScope(
            onWillPop: _willPopCallback,
            child: const Scaffold(
                body: Center(child: CircularProgressIndicator())),
          )
        : WillPopScope(
            onWillPop: _willPopCallback,
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              drawer: DrawerScreen(
                sharedPreferenceHelper: widget.sharedPreferenceHelper,
                refreshApi: cityWeatherCalling,
                refreshApiForest: cityWeatherCalling,
                clearSearch: clearSearch,
                clearSingleSearch: deleteSingleData,
                drawerLat: latitude,
                currentCity: cityList!.name,
                drawerLon: longitude,
              ),
              endDrawer: SettingsScreen(
                boolStatus: tempStatus,
                speed: speedStatus,
                refresh: (value) {
                  setState(() {
                    tempStatus = value;
                  });
                },
                refreshspeed: (value2) {
                  setState(() {
                    speedStatus = value2;
                  });
                },
                refreshAir: (val3) {
                  setState(() {
                    airStatus = val3;
                  });
                },
                air: airStatus,
              ),
              appBar: PreferredSize(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.menu,
                            size: 24,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                      Text(
                        cityList!.name.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w500, fontSize: heading),
                      ),
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.settings,
                            size: 24,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                preferredSize: const Size.fromHeight(kToolbarHeight),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 13, right: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    if (cityList!.cityWeather.isNotEmpty)
                      CityTimeView(
                        cityTime: cityList!.sys,
                        date: cityList!.dt,
                        cityWeather: cityList!.cityWeather,
                        iconName: cityList!.cityWeather[0].icon,
                        refresh: () {
                          setState(() {});
                        },
                        sunset: cityList!.sys.sunset,
                        sunrise: cityList!.sys.sunrise,
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    CitySkyView(
                      wind: cityList!.wind,
                      cityMain: cityList!.main,
                      cityWeather: cityList!.cityWeather,
                      deg: cityList!.wind.deg.toDouble(),
                      status: tempStatus,
                      refresh: (value) {
                        setState(() {
                          tempStatus = value;
                        });
                      },
                      refreshspeed: (value2) {
                        setState(() {
                          speedStatus = value2;
                        });
                      },
                      speed: speedStatus,
                      preciption: cityList!.clouds,
                      tempMax: maxTemp,
                      tempMin: minTemp,
                    ),
                    const Spacer(),
                    (forestList == null)
                        ? const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                              heightFactor: 4,
                            ),
                          )
                        : SizedBox(
                            height: 134,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: forestList?.weatherList.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                if (forestList!.weatherList.isNotEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      right: 5,
                                      left: 4.5,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) => BottomBarCard(
                                            humidity: forestList!
                                                .weatherList[index]
                                                .main
                                                .humidity,
                                            wind: forestList!
                                                .weatherList[index].wind.speed
                                                .toDouble(),
                                            date: forestList!
                                                .weatherList[index].dtTxt,
                                            city: forestList!.city.name
                                                .toString(),
                                            country: forestList!.city.country,
                                            groundLevel: forestList!
                                                .weatherList[index]
                                                .main
                                                .grndLevel
                                                .toDouble(),
                                            percipiation: forestList!
                                                .weatherList[index].clouds.all
                                                .toDouble(),
                                            pod: forestList!
                                                .weatherList[index].sys.pod,
                                            pressure: forestList!
                                                .weatherList[index]
                                                .main
                                                .pressure
                                                .toDouble(),
                                            rain: forestList!
                                                .weatherList[index].pop
                                                .toDouble(),
                                            seaLevel: forestList!
                                                .weatherList[index]
                                                .main
                                                .seaLevel
                                                .toDouble(),
                                            parameter: true,
                                            preStatus: airStatus,
                                            windStatus: speedStatus,
                                            cityWeatherList: cityList,
                                            forestWeatherList: forestList,
                                            index: index,
                                          ),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              (tempStatus)
                                                  ? ((forestList!
                                                                      .weatherList[
                                                                          index]
                                                                      .main
                                                                      .temp *
                                                                  9 /
                                                                  5) +
                                                              32)
                                                          .toInt()
                                                          .toStringAsFixed(0)
                                                          .toString() +
                                                      '°'
                                                  : forestList!
                                                          .weatherList[index]
                                                          .main
                                                          .temp
                                                          .toStringAsFixed(0)
                                                          .toString() +
                                                      '°',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: heading),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Center(
                                            child: SvgPicture.asset(
                                                'assets/weathericon/' +
                                                    forestList!
                                                        .weatherList[index]
                                                        .weather[0]
                                                        .icon +
                                                    '.svg',
                                                height: 48,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                                semanticsLabel:
                                                    'A red up arrow'),
                                          ),
                                          Center(
                                            child: Text(
                                              (tempStatus)
                                                  ? ((forestList!
                                                                      .weatherList[
                                                                          index]
                                                                      .main
                                                                      .tempMin *
                                                                  9 /
                                                                  5) +
                                                              32)
                                                          .toStringAsFixed(0)
                                                          .toString() +
                                                      '°' +
                                                      '/' +
                                                      ((forestList!
                                                                      .weatherList[
                                                                          index]
                                                                      .main
                                                                      .tempMax *
                                                                  9 /
                                                                  5) +
                                                              32)
                                                          .toStringAsFixed(0)
                                                          .toString() +
                                                      '°'
                                                  : forestList!
                                                          .weatherList[index]
                                                          .main
                                                          .tempMin
                                                          .toStringAsFixed(0)
                                                          .toString() +
                                                      '°' +
                                                      '/' +
                                                      forestList!
                                                          .weatherList[index]
                                                          .main
                                                          .tempMax
                                                          .toStringAsFixed(0)
                                                          .toString() +
                                                      '°',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: paraMeter),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: (parseDateStamp(
                                                          cityList!.dt) ==
                                                      parseDateStamp2(
                                                          forestList!
                                                              .weatherList[
                                                                  index]
                                                              .dtTxt))
                                                  ? Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? const Color(0xFF29ccff)
                                                      : const Color(0xFF29ccff)
                                                  : Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? const Color(0xFFd9d9d9)
                                                      : const Color(0xFFd9d9d9),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2,
                                                  bottom: 2,
                                                  left: 5,
                                                  right: 5),
                                              child: Text(
                                                  DateFormat('EEE ').format(
                                                          DateFormat("yyyy-MM-dd hh:mm:ss")
                                                              .parse(forestList!
                                                                  .weatherList[
                                                                      index]
                                                                  .dtTxt)) +
                                                      DateFormat()
                                                          .add_j()
                                                          .format(DateFormat(
                                                                  "yyyy-MM-dd hh:mm:ss")
                                                              .parse(forestList!
                                                                  .weatherList[index]
                                                                  .dtTxt)),
                                                  style: TextStyle(
                                                      color: (parseDateStamp(cityList!.dt) == parseDateStamp2(forestList!.weatherList[index].dtTxt))
                                                          ? Theme.of(context).brightness == Brightness.light
                                                              ? Colors.white
                                                              : Colors.white
                                                          : Theme.of(context).brightness == Brightness.light
                                                              ? const Color(0xFF37474F)
                                                              : Colors.black87,
                                                      fontSize: bottomPara,
                                                      fontWeight: FontWeight.w500)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (forestList!.weatherList.isEmpty) {
                                  return const Text("Empty");
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
  }
}
