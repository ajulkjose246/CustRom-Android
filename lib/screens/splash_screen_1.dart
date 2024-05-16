import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 33, 36, 1),
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Unlock the potential of your Android device with",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Exo-Bold',
                  ),
                ),
              ),
              Text(
                "CustRom",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 0.07,
                  color: Color.fromRGBO(158, 200, 185, 1),
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
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.only(left: 50, right: 50),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(92, 131, 116, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        "Get Started",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.05,
                          fontFamily: 'Exo-Bold',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
