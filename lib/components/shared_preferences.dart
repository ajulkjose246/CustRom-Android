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

  storeDeviceName(String deviceName) {
    prefs.setString("DeviceName", deviceName);
  }

  storeDeviceModelName(String deviceModelName) {
    prefs.setString("DeviceModelName", deviceModelName);
  }

  storeDeviceBrandName(String deviceBrandName) {
    prefs.setString("DeviceBrandName", deviceBrandName);
  }

  storeDeviceManufacturerName(String deviceManufacturerName) {
    prefs.setString("DeviceManufacturerName", deviceManufacturerName);
  }

  getDeviceCode() {
    return prefs.getString("DeviceCode");
  }

  getDeviceName() {
    return prefs.getString("DeviceName");
  }

  getDeviceModelName() {
    return prefs.getString("DeviceModelName");
  }

  getDeviceBrandName() {
    return prefs.getString("DeviceBrandName");
  }

  getDeviceManufacturerName() {
    return prefs.getString("DeviceManufacturerName");
  }
}
