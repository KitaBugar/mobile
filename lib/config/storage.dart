import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  late SharedPreferences pref;

  void init() async {
    pref = await SharedPreferences.getInstance();
  }

  Map get user {
    Map result = {};
    String? user = pref.getString("user");
    log("USER => $user");
    if (user != null) {
      result = jsonDecode(user);
    }
    return result;
  }

  String? get token {
    String? token = pref.getString("jwt_token");
    return token;
  }

  set user(Map value) {
    pref.setString("user", jsonEncode(value));
  }

  set token(String? value) => value;
}

Storage storage = Storage();
