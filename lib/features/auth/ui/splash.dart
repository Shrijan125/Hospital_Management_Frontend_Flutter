import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fontend/features/auth/ui/auth.dart';
import 'package:fontend/utils/constants.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.topToBottom,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 500,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Image.asset('assets/images/splash_screen_logo.png'),
              Positioned(
                  right: 50,
                  bottom: 100,
                  child: DefaultTextStyle(
                      style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            "Caring. Healing. Leading.",
                            speed: const Duration(milliseconds: 100),
                          )
                        ],
                      )))
            ],
          ),
        ),
      ),
      backgroundColor: backgroudColor,
    );
  }
}
