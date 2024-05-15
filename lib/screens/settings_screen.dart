// ignore_for_file: non_constant_identifier_names

import 'package:custrom/components/shared_preferences.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _databaseReference = FirebaseDatabase.instance.ref("devices");

  String deviceCodeName = '';
  String DeviceModelName = '';
  String DeviceBrandName = '';
  String DeviceManufacturerName = '';
  String DeviceName = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      deviceCodeName = SharedPreferencesService().getDeviceCode();
      DeviceModelName = SharedPreferencesService().getDeviceModelName();
      DeviceBrandName = SharedPreferencesService().getDeviceBrandName();
      DeviceManufacturerName =
          SharedPreferencesService().getDeviceManufacturerName();
      fetchData();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchData() async {
    try {
      final snapshot = await _databaseReference.child('redwood').get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<Object?, Object?>;
        data.forEach((key, value) {
          if (key == 'name') {
            setState(() {
              DeviceName = (value as String?)!;
            });
            print(DeviceName);
          }
        });
      } else {
        print('No data available.');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 300,
          child: DotLottieLoader.fromAsset("assets/android.lottie",
              frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
            if (dotlottie != null) {
              return Lottie.memory(dotlottie.animations.values.single);
            } else {
              return Container();
            }
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(48, 49, 52, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DeviceInfoText(
                  label: "Brand : ",
                  value: DeviceBrandName,
                ),
                DeviceInfoText(
                  label: "Device : ",
                  value: deviceCodeName,
                ),
                DeviceInfoText(
                  label: "Model : ",
                  value: DeviceModelName,
                ),
                DeviceInfoText(
                  label: "Manufacturer : ",
                  value: DeviceManufacturerName,
                ),
                DeviceInfoText(
                  label: "Name : ",
                  value: DeviceName,
                ),
              ],
            ),
          ),
        ),
        const BtnFW(
          label: 'Change Device',
        )
      ],
    );
  }
}

class BtnFW extends StatelessWidget {
  const BtnFW({
    super.key,
    required this.label,
  });
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/splashScreen2');
        },
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
              child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Exo-Bold',
              fontSize: 15,
            ),
          )),
        ),
      ),
    );
  }
}

class DeviceInfoText extends StatelessWidget {
  const DeviceInfoText({
    super.key,
    required this.label,
    required this.value,
  });
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Exo-Bold',
            fontSize: 15,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Exo-Bold',
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
