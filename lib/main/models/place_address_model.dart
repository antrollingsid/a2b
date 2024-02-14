class PlaceAddressModel {
  double? latitude;
  double? longitude;
  String? placeId;
  String? placeAddress;

  PlaceAddressModel(
      {this.latitude, this.longitude, this.placeId, this.placeAddress});

  factory PlaceAddressModel.fromJson(Map<String, dynamic> json) {
    return PlaceAddressModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      placeId: json['placeId'],
      placeAddress: json['placeAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['placeId'] = placeId;
    data['placeAddress'] = placeAddress;
    return data;
  }
}
