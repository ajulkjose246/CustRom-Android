import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          DotLottieLoader.fromAsset("assets/intro.lottie",
              frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
            if (dotlottie != null) {
              return Lottie.memory(dotlottie.animations.values.single);
            } else {
              return Container();
            }
          }),
          const Spacer(),
          const Column(
            children: [
              Text(
                "Unlock the potential of your Android device with",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Exo-Bold',
                ),
              ),
              Text(
                "CustRom",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: Color.fromRGBO(252, 123, 113, 1),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Exo-Bold',
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/splashScreen2', (route) => false);
            },
            child: Container(
              width: 250,
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(92, 131, 116, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Get Started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Exo-Bold',
                    ),
                  ),
                  Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
