import 'dart:async';

import 'package:family_space_flutter/repositories/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesAuthRepository extends AuthRepository {
  static const authTokenKey = 'auth_token';
  @override
  Future<String?> getToken() async =>
      (await SharedPreferences.getInstance()).getString(authTokenKey);

  @override
  Future<void> setToken(String token) async {
    await (await SharedPreferences.getInstance())
        .setString(authTokenKey, token);
    notifyListeners();
  }

  @override
  Future<void> removeToken() async {
    await (await SharedPreferences.getInstance()).remove(authTokenKey);
    notifyListeners();
  }
}
