class ForecastWeather {
  final String cod;
  final int message;
  final int cnt;
  final List<Listt> weatherList;
  final City city;

  ForecastWeather(
      {required this.cod,
      required this.message,
      required this.cnt,
      required this.weatherList,
      required this.city});

  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    return ForecastWeather(
        cod: json['cod'] as String,
        message: json['message'] as int,
        cnt: json['cnt'] as int,
        weatherList: (json['list'] as List<dynamic>)
            .map((tagJson) => Listt.fromJson(tagJson))
            .toList(),
        city: City.fromJson(json['city']));
  }

  @override
  String toString() {
    return 'City_Weather{cod: $cod, message: $message, cnt: $cnt, weather_lisst: $weatherList, city: $city}';
  }
}

class Listt {
  final int dt;
  final Main main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final num pop;
  final Sys sys;
  final String dtTxt;

  factory Listt.fromJson(Map<String, dynamic> json) {
    return Listt(
      dt: json['dt'] as int,
      main: Main.fromJson(json['main']),
      weather: (json['weather'] as List<dynamic>)
          .map((tagJson) => Weather.fromJson(tagJson))
          .toList(),
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: json['pop'],
      sys: Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
    );
  }

  Listt(
      {required this.dt,
      required this.main,
      required this.weather,
      required this.clouds,
      required this.wind,
      required this.visibility,
      required this.pop,
      required this.sys,
      required this.dtTxt});

  @override
  String toString() {
    return 'Listt{dt: $dt, main: $main, weather: $weather, clouds: $clouds, wind: $wind, visibility: $visibility, pop: $pop, sys: $sys, dtTxt: $dtTxt}';
  }
}

class Main {
  final num temp;
  final num feelsLike;
  final num tempMin;
  final num tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final num tempKf;

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: json['temp_kf'],
    );
  }
  Main(
      {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.seaLevel,
      required this.grndLevel,
      required this.humidity,
      required this.tempKf});

  @override
  String toString() {
    return 'Main{temp: $temp, feelsLike: $feelsLike, tempMin: $tempMin, tempMax: $tempMax, pressure: $pressure, seaLevel: $seaLevel, grndLevel: $grndLevel, humidity: $humidity, tempKf: $tempKf}';
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
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

class Wind {
  final num speed;
  final int deg;
  final num gust;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'],
      deg: json['deg'] as int,
      gust: json['gust'],
    );
  }

  @override
  String toString() {
    return 'Wind{speed: $speed, deg: $deg, gust: $gust}';
  }
}

class Sys {
  final String pod;

  Sys({required this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: json['pod'] as String,
    );
  }

  @override
  String toString() {
    return 'Sys{pod: $pod}';
  }
}

class City {
  final int id;
  final String? name;
  final Cord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as int,
      name: json['name'],
      coord: Cord.fromJson(json['coord']),
      country: json['country'] as String,
      population: json['population'] as int,
      timezone: json['timezone'] as int,
      sunrise: json['sunrise'] as int,
      sunset: json['sunset'] as int,
    );
  }

  @override
  String toString() {
    return 'City{id: $id, name: $name, coord: $coord, country: $country, population: $population, timezone: $timezone, sunrise: $sunrise, sunset: $sunset}';
  }

  City(
      {required this.id,
      required this.name,
      required this.coord,
      required this.country,
      required this.population,
      required this.timezone,
      required this.sunrise,
      required this.sunset});
}

class Cord {
  final double lat;
  final double lon;

  Cord({required this.lat, required this.lon});

  factory Cord.fromJson(Map<String, dynamic> json) {
    return Cord(
      lat: json['lat'] as double,
      lon: json['lon'] as double,
    );
  }

  @override
  String toString() {
    return 'Coord{lat: $lat, lon: $lon}';
  }
}
