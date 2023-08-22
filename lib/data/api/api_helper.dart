import 'package:http/http.dart' as http;
import 'package:weather_stream/data/model/callingFromId.dart';
import 'dart:async';
import 'dart:convert';
import 'package:weather_stream/data/model/cityweather_detail.dart';
import 'package:weather_stream/data/model/forecastweather.dart';
import 'package:weather_stream/data/model/geocoding.dart';
import 'package:weather_stream/data/model/drawerhistory.dart';
import 'package:weather_stream/data/model/suggestion.dart';

String url = 'https://api.openweathermap.org/data/2.5/';
const String androidKey = 'AIzaSyCe2AX8feMvRO1_Q2fV5eERERm0RAX_1a0';

class ApiHelper {
  Future<ForecastWeather> getForecast(double lat, double lon) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&appid=96c43fadb75c94b95081c34d056723bb');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      ForecastWeather userresponse =
          ForecastWeather.fromJson(jsonDecode(response.body));
      return userresponse;
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  Future<List<Geocoding>> getPlaceListByKeyword(String value) async {
    final response = await http.get(
      Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q=$value'),
      headers: {
        'x-api-key': '96c43fadb75c94b95081c34d056723bb',
      },
    );
    if (response.statusCode == 200) {
      SearchLocation geoProduct =
          SearchLocation.fromJson(jsonDecode(response.body));
      return geoProduct.searchList;
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  Future<List<Predictions>> fetchSuggestions(String input, String token) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$androidKey&sessiontoken=$token'));
    if (response.statusCode == 200) {
      PlaceIdApi userresponse = PlaceIdApi.fromJson(jsonDecode(response.body));

      return userresponse.predictions;
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  Future<ForecastWeather> requestForecast(double lat, double lon) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&appid=96c43fadb75c94b95081c34d056723bb');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      ForecastWeather userresponse =
          ForecastWeather.fromJson(jsonDecode(response.body));
      return userresponse;
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  //
  Future<Location?> requestFromPlaceId(String id) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&key=AIzaSyCe2AX8feMvRO1_Q2fV5eERERm0RAX_1a0&sessiontoken=sdf');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      PlaceIdCalling locations =
          PlaceIdCalling.fromJson(jsonDecode(response.body));

      return locations.result.geometry.location;
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  Future<List<Geocoding>> requestGeocoding(String value) async {
    final response = await http.get(
      Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q=$value'),
      // Send authorization headers to the backend.
      headers: {
        'x-api-key': '96c43fadb75c94b95081c34d056723bb',
      },
    );
    if (response.statusCode == 200) {
      SearchLocation geoProduct =
          SearchLocation.fromJson(jsonDecode(response.body));
      return geoProduct.searchList;
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  Future<CityWeather> requestCityWeather(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(url + 'weather?lat=$lat&lon=$lon&units=metric&'),
      // Send authorization headers to the backend.
      headers: {
        'x-api-key': '96c43fadb75c94b95081c34d056723bb',
      },
    );
    if (response.statusCode == 200) {
      CityWeather cityProduct = CityWeather.fromJson(jsonDecode(response.body));

      return cityProduct;
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  Future<List<DrawerHistory>> apiCallingByName(
      List<DrawerHistory> history) async {
    var responses = await Future.wait(history
        .map((e) => http.get(
              Uri.parse(url +
                  'weather?lat=' +
                  e.lat.toString() +
                  '&lon=' +
                  e.lon.toString() +
                  '&units=metric&'),
              headers: {
                'x-api-key': '96c43fadb75c94b95081c34d056723bb',
              },
            ))
        .toList());
    return responses
        .map((e) => CityWeather.fromJson(jsonDecode(e.body)))
        .map((e) => DrawerHistory(
              name: e.name,
              lat: e.cord.lat,
              lon: e.cord.lon,
              country: e.sys.country,
              temp: e.main.temp.toDouble(),
              imageUrl: e.cityWeather.first.icon,
            ))
        .toList();
  }
}
