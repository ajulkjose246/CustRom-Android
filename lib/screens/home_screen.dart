// ignore_for_file: non_constant_identifier_names, avoid_print
import 'package:custrom/components/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _databaseReference = FirebaseDatabase.instance.ref("devices");

  var deviceCodeName = '';
  bool DeviceData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      deviceCodeName = SharedPreferencesService().getDeviceCode();
      fetchData();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchData() async {
    try {
      final snapshot =
          await _databaseReference.child("$deviceCodeName/roms").get();
      if (snapshot.exists) {
        setState(() {
          DeviceData = true;
        });
      } else {
        setState(() {
          DeviceData = false;
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)), // Delay for 2 seconds
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Show loading indicator during delay
        } else {
          return DeviceData
              ? FirebaseAnimatedList(
                  query: _databaseReference.child("$deviceCodeName/roms"),
                  itemBuilder: (context, snapshot, animation, index) {
                    var romname = snapshot.key.toString();
                    var romurl = snapshot.value.toString();
                    return RomCard(
                      romurl: romurl,
                      romname: romname,
                    );
                    // If snapshot is empty or null
                  },
                )
              : Container(
                  margin: const EdgeInsets.all(8.0),
                  height: 100,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(48, 49, 52, 1),
                      borderRadius: BorderRadius.circular(16)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "There is no custom roms",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Exo-Bold',
                          color: Colors.white,
                        ),
                      )
                    ],
                  ));
        }
      },
    );
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
        try {
          final Uri url = Uri.parse(romurl);
          if (!await launchUrl(url)) {
            throw Exception('Could not launch $url');
          }
        } catch (e) {
          print(e);
        }
      },
      child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(48, 49, 52, 1),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  romname,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Exo-Bold',
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
