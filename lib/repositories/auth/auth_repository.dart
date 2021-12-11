import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class AuthRepository extends ChangeNotifier {
  Future<String?> getToken();
  Future<void> setToken(String token);
  Future<void> removeToken();
}
