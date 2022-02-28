import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'god_father.dart';
import 'shared_prefs_keys.dart';

class AppUtils {

  static void logout(BuildContext context) async {
    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();
    if (context != null) {
      if (_sharedPreferences.getString(SharedPrefsKeys.USER_TOKEN) != null ||
          _sharedPreferences.getString(SharedPrefsKeys.USER_DATA) != null) {
        await _sharedPreferences.clear();
        GodFather.restartApp(context);
      }
    } else {
      print("app utils context is null");
    }
  }
}