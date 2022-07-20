class CityWeather {
  final Coord cord;
  final List<CityMainWeather> cityWeather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  factory CityWeather.fromJson(Map<String, dynamic> json) {
    return CityWeather(
      cord: Coord.fromJson(json['coord']),
      base: json['base'] as String,
      main: Main.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      timezone: json['timezone'],
      id: json['id'] as int,
      name: json['name'] as String,
      cod: json['cod'],
      cityWeather: (json['weather'] as List<dynamic>)
          .map((tagJson) => CityMainWeather.fromJson(tagJson))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'City_Detail{coord: $cord, weather: $cityWeather, base: $base, main: $main, visibility: $visibility, wind: $wind, clouds: $clouds, dt: $dt, sys: $sys, timezone: $timezone, id: $id, name: $name, cod: $cod}';
  }

  CityWeather(
      {required this.cord,
      required this.cityWeather,
      required this.base,
      required this.main,
      required this.visibility,
      required this.wind,
      required this.clouds,
      required this.dt,
      required this.sys,
      required this.timezone,
      required this.id,
      required this.name,
      required this.cod});
}

class Coord {
  final double lon;
  final double lat;

  Coord({required this.lon, required this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'] as double,
      lat: json['lat'] as double,
    );
  }

  @override
  String toString() {
    return 'Coord{lon: $lon, lat: $lat}';
  }
}

class CityMainWeather {
  final int id;
  final String main;
  final String description;
  final String icon;

  CityMainWeather(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  factory CityMainWeather.fromJson(Map<String, dynamic> json) {
    return CityMainWeather(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }

  @override
  String toString() {
    return 'Weather{id: $id, main: $main, description: $description, icon: $icon}';
  }
}

class Main {
  final num temp;
  final num feelsLike;
  final num tempMin;
  final num tempMax;
  final num pressure;
  final num humidity;

  Main(
      {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.humidity});

  @override
  String toString() {
    return 'Main{temp: $temp, feelsLike: $feelsLike, tempMin: $tempMin, tempMax: $tempMax, pressure: $pressure, humidity: $humidity}';
  }

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }
}

class Wind {
  final num speed;
  final int deg;

  Wind({required this.speed, required this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: json['speed'], deg: json['deg'] as int);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    return data;
  }

  @override
  String toString() {
    return 'Wind{speed: $speed, deg: $deg}';
  }
}

class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'] as int,
    );
  }

  @override
  String toString() {
    return 'Clouds{all: $all}';
  }
}

class Sys {
  final int? type;
  final int? id;
  final double? message;
  final String country;
  final int sunrise;
  final int sunset;

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'],
      id: json['id'],
      message: json['message'],
      country: json['country'] as String,
      sunrise: json['sunrise'] as int,
      sunset: json['sunset'] as int,
    );
  }

  Sys(
      {required this.type,
      required this.id,
      required this.message,
      required this.country,
      required this.sunrise,
      required this.sunset});

  @override
  String toString() {
    return 'Sys{type: $type, id: $id, message: $message, country: $country, sunrise: $sunrise, sunset: $sunset}';
  }
}
