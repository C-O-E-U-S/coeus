import 'dart:async';
import 'package:coeus/welcome.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.ca});
  final ca;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  void _navigateAfter() {
    print("done timer");
    // Get.to(MyHomePage());
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => Welcome(
              cameran: widget.ca,
            )));
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), _navigateAfter);
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
            Colors.deepPurple,
            Color.fromARGB(255, 215, 166, 219)
          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
                //     child: Image.asset(
                //   "lib/hipi.png",
                //   width: 250,
                // )
                child: Text(
              "C.0.E.U.S",
              style: TextStyle(fontSize: 28, color: Colors.white),
            )),
          ),
        ],
      ),
    );
  }
}
