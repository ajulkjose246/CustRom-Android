// ignore_for_file: non_constant_identifier_names

import 'package:custrom/components/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  String deviceCodeName = '';
  String deviceModelName = '';
  String deviceBrandName = '';
  String deviceManufacturerName = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getDeviceName();
  }

  Future<void> getDeviceName() async {
    String Name = '';
    String Model = '';
    String Brand = '';
    String Manufacturer = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      Name = androidInfo.device;
      Model = androidInfo.model;
      Brand = androidInfo.brand;
      Manufacturer = androidInfo.manufacturer;
    }
    setState(() {
      deviceCodeName = Name;
      deviceModelName = Model;
      deviceBrandName = Brand;
      deviceManufacturerName = Manufacturer;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: const Color.fromRGBO(32, 33, 36, 1),
      backgroundColor: const Color.fromRGBO(48, 49, 52, 1),
      body: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(32, 33, 36, 1),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            child: DotLottieLoader.fromAsset("assets/android.lottie",
                frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
              if (dotlottie != null) {
                return Lottie.memory(dotlottie.animations.values.single);
              } else {
                return Container();
              }
            }),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.02, horizontal: width * 0.1),
            color: const Color.fromRGBO(48, 49, 52, 1),
            child: Column(
              children: [
                SizedBox(height: height * 0.02), // Spacer
                buildDeviceInfoRow("Device Name :", deviceCodeName),
                SizedBox(height: height * 0.02),
                buildDeviceInfoRow("Device Model :", deviceModelName),
                SizedBox(height: height * 0.02),
                buildDeviceInfoRow("Device Brand :", deviceBrandName),
                SizedBox(height: height * 0.02),
                buildDeviceInfoRow(
                    "Device Manufacturer :", deviceManufacturerName),

                SizedBox(height: height * 0.02), // Spacer
                buildButtonRow(context, deviceModelName, deviceBrandName,
                    deviceManufacturerName, deviceCodeName),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildDeviceInfoRow(String label, String value) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(92, 131, 116, 1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontFamily: 'Exo-Bold',
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            value.isNotEmpty ? value : 'Loading...',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'Exo-Bold',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildButtonRow(
    BuildContext context,
    String deviceModelName,
    String deviceBrandName,
    String deviceManufacturerName,
    String deviceCodeName) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/selectDevice');
        },
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Edit",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Exo-Bold',
                ),
              ),
              Icon(
                Icons.edit_note,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
      const SizedBox(width: 10), // Spacer
      GestureDetector(
        onTap: () {
          SharedPreferencesService().storeDeviceCode(deviceCodeName);
          SharedPreferencesService().storeDeviceBrandName(deviceBrandName);
          SharedPreferencesService()
              .storeDeviceManufacturerName(deviceManufacturerName);
          SharedPreferencesService().storeDeviceModelName(deviceModelName);
          Navigator.pushNamedAndRemoveUntil(context, '/dash', (route) => false);
        },
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Confirm",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Exo-Bold',
                ),
              ),
              Icon(
                Icons.arrow_right_alt_outlined,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    ],
  );
}
