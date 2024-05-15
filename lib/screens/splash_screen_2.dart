// ignore_for_file: non_constant_identifier_names

import 'package:custrom/components/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 33, 36, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: DotLottieLoader.fromAsset("assets/android.lottie",
                  frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(dotlottie.animations.values.single);
                } else {
                  return Container();
                }
              }),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(48, 49, 52, 1),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(92, 131, 116, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Device Name : ',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'Exo-Bold',
                              ),
                            ),
                            Text(
                              deviceCodeName.isNotEmpty
                                  ? deviceCodeName
                                  : 'Loading...',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Exo-Bold',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(92, 131, 116, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Device Model : ',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'Exo-Bold',
                              ),
                            ),
                            Text(
                              deviceModelName.isNotEmpty
                                  ? deviceModelName
                                  : 'Loading...',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'Exo-Bold',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(92, 131, 116, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Device Brand : ',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'Exo-Bold',
                              ),
                            ),
                            Text(
                              deviceBrandName.isNotEmpty
                                  ? deviceBrandName
                                  : 'Loading...',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'Exo-Bold',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(92, 131, 116, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Device Manufacturer : ',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'Exo-Bold',
                              ),
                            ),
                            Text(
                              deviceManufacturerName.isNotEmpty
                                  ? deviceManufacturerName
                                  : 'Loading...',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'Exo-Bold',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          SharedPreferencesService()
                              .storeDeviceCode(deviceCodeName);
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false);
                        },
                        child: Container(
                          width: 150,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(158, 200, 185, 1),
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
                                  fontSize: 20,
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
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
