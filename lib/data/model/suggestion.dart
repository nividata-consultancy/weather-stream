class PlaceIdApi {
  final List<Predictions> predictions;

  PlaceIdApi({required this.predictions});

  factory PlaceIdApi.fromJson(Map<String, dynamic> json) {
    return PlaceIdApi(
      predictions: (json['predictions'] as List<dynamic>)
          .map((tagJson) => Predictions.fromJson(tagJson))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'suggestion{predictions: $predictions}';
  }
}

class Predictions {
  final String description;
  final String placeId;

  Predictions({required this.description, required this.placeId});
  factory Predictions.fromJson(Map<String, dynamic> json) {
    return Predictions(
      placeId: json['place_id'],
      description: json['description'],
    );
  }

  @override
  String toString() {
    return 'Predictions{description: $description, placeid: $placeId}';
  }
}
