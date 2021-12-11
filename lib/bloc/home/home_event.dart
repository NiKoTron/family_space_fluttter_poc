import 'package:family_space_flutter/bloc/home/home_state.dart';
import 'package:family_space_flutter/model/coordinates.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.init() = InitHomeEvent;
  const factory HomeEvent.updateMyLocation(Coordinates location) =
      UpdateMyLocationHomeEvent;

  const factory HomeEvent.setMapProvider(MapProvider mapProvider) =
      SetMapProviderHomeEvent;
  const factory HomeEvent.logOut() = LogOutHomeEvent;
}
