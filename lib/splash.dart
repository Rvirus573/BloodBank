import 'package:bloodbank/model/login_user_check.dart';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

SplashService splashService = SplashService();

class _SplashState extends State<Splash> {
  chooseScreen(context) {
    Future.delayed(const Duration(seconds: 4), () => splashService.isLogin());
  }

  // loginOrHomeScreen() {
  //   final box = GetStorage();
  //   var value = box.read("login_true");

  //   if (value == true) {
  //     Get.toNamed(home);
  //   } else {
  //     Get.toNamed(login);
  //   }
  // }

  @override
  void initState() {
    super.initState();

    chooseScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/bloodjson.json',
              height: 300,
              repeat: true,
              reverse: true,
              // controller: _controller,
              onLoaded: (composition) {
                // Configure the AnimationController with the duration of the
                // Lottie file and start the animation.
              },
            ),
          ],
        ),
      )),
    );
  }
}
