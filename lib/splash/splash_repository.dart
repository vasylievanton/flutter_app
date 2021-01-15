import 'dart:convert';

import 'package:flutter_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  // ignore: missing_return
  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      return User.fromJson(jsonDecode(prefs.get('user')));
    }
  }

  setUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.toJson().toString());
  }
}
