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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      deviceCodeName = SharedPreferencesService().getDeviceCode();
    } catch (e) {
      print(e);
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
          return FirebaseAnimatedList(
            query: _databaseReference.child("$deviceCodeName/roms"),
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
        final Uri url = Uri.parse(romurl);
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        }
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
