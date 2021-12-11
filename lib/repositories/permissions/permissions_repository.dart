abstract class PermissionsRepository {
  Future<bool> isLocationPermitionGranted({requestIfNeeded = true});
}
