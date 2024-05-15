import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences prefs;
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
  }

  storeDeviceCode(String deviceCode) {
    prefs.setString("DeviceCode", deviceCode);
  }

  getDeviceCode() {
    return prefs.getString("DeviceCode");
  }
}
