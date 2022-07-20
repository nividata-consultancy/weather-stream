class PlaceIdCalling {
  Result result;

  PlaceIdCalling({
    required this.result,
  });

  factory PlaceIdCalling.fromJson(Map<String, dynamic> json) {
    return PlaceIdCalling(
      result: Result.fromJson(json['result']),
    );
  }
}

class Result {
  final Geometry geometry;

  Result({
    required this.geometry,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      geometry: Geometry.fromJson(json['geometry']),
    );
  }
}

class Geometry {
  final Location location;

  Geometry({
    required this.location,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(json['location']),
    );
  }
}

class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
