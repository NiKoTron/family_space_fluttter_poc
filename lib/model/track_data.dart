import 'package:family_space_flutter/model/coordinates.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'track_data.g.dart';

@JsonSerializable()
class TrackData {
  final Map<String, Coordinates> coordinatesHistory;

  TrackData({
    required this.coordinatesHistory,
  });

  factory TrackData.fromJson(Map<String, dynamic> json) =>
      _$TrackDataFromJson(json);

  Map<String, dynamic> toJson() => _$TrackDataToJson(this);
}
