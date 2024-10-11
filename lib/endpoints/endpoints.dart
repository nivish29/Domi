class MapApiEndpoints {
  static const String apiKey = 'AIzaSyBdpHK36b_FWVj9KIDXfkJx3RUzGnbCcOU';

  static String getNearestPlaceEndpoint(double latitude, double longitude) {
    return 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=$latitude,$longitude'
        '&radius=10'
        '&type=establishment'
        '&key=$apiKey';
  }

  static String getBuildingOutlineEndpoint(double latitude, double longitude) {
    return """
    [out:json];
    way(around:10,$latitude,$longitude)[building];
    (._;>;);
    out geom;
    """;
  }

  static String getBuildingOutlineUrl() {
    return 'https://overpass-api.de/api/interpreter';
  }
}
