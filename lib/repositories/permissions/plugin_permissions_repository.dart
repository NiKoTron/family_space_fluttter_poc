import 'package:family_space_flutter/repositories/permissions/permissions_repository.dart';
import 'package:location/location.dart';

class PluginPermissionsRepository extends PermissionsRepository {
  @override
  Future<bool> isLocationPermitionGranted({requestIfNeeded = true}) async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await Location.instance.serviceEnabled();
    if (!_serviceEnabled) {
      if (!requestIfNeeded) {
        return false;
      }
      _serviceEnabled = await Location.instance.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    _permissionGranted = await Location.instance.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      if (!requestIfNeeded) {
        return false;
      }
      _permissionGranted = await Location.instance.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }
}
