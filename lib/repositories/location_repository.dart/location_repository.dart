import 'package:family_space_flutter/model/coordinates.dart';

abstract class LocationRepository {
  Future<Coordinates> getCurrentLocation();
  Stream<Coordinates> currentLocationStream();
}
