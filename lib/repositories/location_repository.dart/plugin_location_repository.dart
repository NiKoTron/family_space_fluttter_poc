import 'package:family_space_flutter/model/coordinates.dart';
import 'package:family_space_flutter/repositories/location_repository.dart/location_repository.dart';
import 'package:location/location.dart';

class PluginLocationRepository extends LocationRepository {
  Location locationService;
  PluginLocationRepository(this.locationService);

  @override
  Future<Coordinates> getCurrentLocation() async =>
      (await locationService.getLocation()).toCoordinates();

  @override
  Stream<Coordinates> currentLocationStream() =>
      locationService.onLocationChanged.map((event) => event.toCoordinates());
}

extension _LocationDataExtension on LocationData {
  Coordinates toCoordinates() => Coordinates(
        latitude: latitude ?? 0,
        longitude: longitude ?? 0,
      );
}
