import 'package:custrom/components/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectDevice extends StatefulWidget {
  const SelectDevice({super.key});

  @override
  State<SelectDevice> createState() => _SelectDeviceState();
}

class _SelectDeviceState extends State<SelectDevice> {
  final _databaseReference = FirebaseDatabase.instance.ref("devices");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text(
            "Select Device",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Exo-Bold',
              fontSize: 20,
            ),
          ),
          backgroundColor: const Color.fromRGBO(32, 33, 36, 1),
        ),
        backgroundColor: const Color.fromRGBO(32, 33, 36, 1),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    "Enter the Device Name",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                future: Future.delayed(
                    const Duration(seconds: 1)), // Delay for 2 seconds
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    ); // Show loading indicator during delay
                  } else {
                    return FirebaseAnimatedList(
                      query: _databaseReference,
                      itemBuilder: (context, snapshot, animation, index) {
                        if (snapshot.value != null) {
                          var romname = snapshot.key.toString();
                          var romurl = snapshot.value.toString();
                          return RomCard(
                            romurl: romurl,
                            romname: romname,
                          );
                        } else {
                          return const ListTile(
                            title: Text(
                              'No data available',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}

class RomCard extends StatelessWidget {
  const RomCard({
    super.key,
    required this.romurl,
    required this.romname,
  });

  final String romurl;
  final String romname;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        SharedPreferencesService().storeDeviceCode(romname);
        SharedPreferencesService().storeDeviceBrandName("");
        SharedPreferencesService().storeDeviceManufacturerName("");
        SharedPreferencesService().storeDeviceModelName("");
        SharedPreferencesService().storeDeviceName("");
        Navigator.pushNamedAndRemoveUntil(context, '/dash', (route) => false);
        Navigator.pushNamedAndRemoveUntil(context, '/dash', (route) => false);
      },
      child: Container(
          margin: const EdgeInsets.all(8.0),
          height: 100,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(48, 49, 52, 1),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                romname,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Exo-Bold',
                  color: Colors.white,
                ),
              )
            ],
          )),
    );
  }
}
