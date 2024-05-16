// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'package:custrom/components/shared_preferences.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _databaseReference = FirebaseDatabase.instance.ref("devices");
  final _databaseRequestReference = FirebaseDatabase.instance.ref("request");

  final devicename_controller = TextEditingController();
  final romname_controller = TextEditingController();

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
      final snapshot = await _databaseReference.child(deviceCodeName).get();
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

  Future<void> _submitDeviceAndRom(String deviceName, String romName) async {
    bool romAlready = false;
    final snapshot =
        await _databaseRequestReference.child("Roms").child(deviceName).get();
    if (snapshot.value != null) {
      final data = snapshot.value as Map<Object?, Object?>;
      data.forEach((key, value) {
        if (value == romName) {
          romAlready = true;
        }
      });
      if (!romAlready) {
        String dataLength = data.length.toString();
        _databaseRequestReference.child("Roms").child(deviceName).update({
          dataLength: romName,
        });
      }
    } else {
      _databaseRequestReference.child("Roms").child(deviceName).set({
        'Name': deviceName,
        '1': romName,
      });
    }
  }

  Future<void> _submitDevice(String deviceName) async {
    final snapshot = await _databaseRequestReference
        .child("Devices")
        .child(deviceName)
        .get();
    if (snapshot.value != null) {
      print("Aleady existing device");
    } else {
      _databaseRequestReference.child("Devices").update({
        deviceName: deviceName,
      });
      print("suceess");
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
            decoration: BoxDecoration(
              color: const Color.fromRGBO(48, 49, 52, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DeviceInfoText(
                    label: "Brand",
                    value: DeviceBrandName,
                  ),
                  DeviceInfoText(
                    label: "Device",
                    value: deviceCodeName,
                  ),
                  DeviceInfoText(
                    label: "Model",
                    value: DeviceModelName,
                  ),
                  DeviceInfoText(
                    label: "Manufacturer",
                    value: DeviceManufacturerName,
                  ),
                  DeviceInfoText(
                    label: "Name",
                    value: DeviceName,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
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
              child: const Center(
                  child: Text(
                "Change Device",
                style: TextStyle(
                  fontFamily: 'Exo-Bold',
                  fontSize: 15,
                ),
              )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: const Color.fromRGBO(48, 49, 52, 1),
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              controller: devicename_controller,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                label: Text("Enter Device Name"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  _submitDevice(
                                    devicename_controller.text.toString(),
                                  );
                                  devicename_controller.clear();
                                  Fluttertoast.showToast(
                                    msg:
                                        "Your request has been successfully recorded",
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  ).then(
                                    (value) => Navigator.pop(context),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    "Change Device",
                                    style: TextStyle(
                                      fontFamily: 'Exo-Bold',
                                      fontSize: 15,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                  child: Text(
                "Request Device",
                style: TextStyle(
                  fontFamily: 'Exo-Bold',
                  fontSize: 15,
                ),
              )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: const Color.fromRGBO(48, 49, 52, 1),
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              controller: devicename_controller,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                label: Text("Enter Device Name"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              controller: romname_controller,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                label: Text("Enter Device Name"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  var device =
                                      devicename_controller.text.toString();
                                  _submitDeviceAndRom(
                                    device,
                                    romname_controller.text.toString(),
                                  );
                                  devicename_controller.clear();
                                  romname_controller.clear();
                                  Fluttertoast.showToast(
                                    msg:
                                        "Your request has been successfully recorded",
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  ).then(
                                    (value) => Navigator.pop(context),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    "Change Device",
                                    style: TextStyle(
                                      fontFamily: 'Exo-Bold',
                                      fontSize: 15,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                  child: Text(
                "Request Custom Rom",
                style: TextStyle(
                  fontFamily: 'Exo-Bold',
                  fontSize: 15,
                ),
              )),
            ),
          ),
        )
      ],
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
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            label,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Exo-Bold',
              fontSize: 15,
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            " : $value",
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Exo-Bold',
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
