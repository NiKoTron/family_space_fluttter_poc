import 'package:family_space_flutter/model/banner.dart';
import 'package:family_space_flutter/model/coordinates.dart';
import 'package:family_space_flutter/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

enum MapProvider {
  googleMaps,
  mapBox,
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    Coordinates? myLocation,
    Coordinates? homeLocation,
    String? homeGeocoded,
    String? currentPosition,
    List<Coordinates>? displayedTrack,
    List<User>? participants,
    List<Banner>? banners,
    @Default(MapProvider.googleMaps) MapProvider mapProvider,
  }) = _HomeState;
}
