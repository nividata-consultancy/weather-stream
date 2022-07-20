class SearchLocation {
  SearchLocation({required this.searchList});

  final List<Geocoding> searchList;

  factory SearchLocation.fromJson(List<dynamic> json) {
    return SearchLocation(
        searchList:
            (json).map((tagJson) => Geocoding.fromJson(tagJson)).toList());
  }
}

class Geocoding {
  final String name;
  final double lat;
  final double lon;
  final String country;
  final String state;

  Geocoding({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  factory Geocoding.fromJson(Map<String, dynamic> json) {
    return Geocoding(
      name: json['name'],
      lon: json['lon'],
      lat: json['lat'],
      country: json['country'],
      state: json['state'],
    );
  }

  @override
  String toString() {
    return 'Geocoding{name: $name, lat: $lat, lon: $lon, country: $country, state: $state}';
  }
}
