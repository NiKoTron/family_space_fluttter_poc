import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mapbox_gl/mapbox_gl.dart' as mapbox;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;

part 'coordinates.g.dart';

@JsonSerializable()
class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}

extension CoordinatesExtension on Coordinates {
  mapbox.LatLng toMapBoxLatLng() => mapbox.LatLng(latitude, longitude);
  gmaps.LatLng toGMapsLatLng() => gmaps.LatLng(latitude, longitude);
}
