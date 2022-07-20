class DrawerHistory {
  final String name;
  final double lat;
  final double lon;
  final String country;
  final double temp;
  final String imageUrl;

  DrawerHistory({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.temp,
    required this.imageUrl,
  });

  factory DrawerHistory.fromJson(Map<String, dynamic> json) {
    return DrawerHistory(
      name: json['name'],
      lon: json['lon'],
      lat: json['lat'],
      country: json['country'],
      temp: json['temp'],
      imageUrl: json['imageUrl'],
    );
  }

  @override
  String toString() {
    return 'History{name: $name, lat: $lat, lon: $lon, country: $country, temp: $temp, imageUrl: $imageUrl}';
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "lon": lon,
      "lat": lat,
      "country": country,
      "temp": temp,
      "imageUrl": imageUrl,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrawerHistory &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          country == other.country;

  @override
  int get hashCode => name.hashCode ^ country.hashCode;
}
