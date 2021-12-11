import 'package:family_space_flutter/model/coordinates.dart';

abstract class TracksRepository {
  Future<List<Coordinates>> getTrack();

  Future<Coordinates> getHomeLocation();
  Future<String> getHomeAddress();
}
