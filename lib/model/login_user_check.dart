import 'package:bloodbank/route/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashService {
  void isLogin() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Future.delayed(const Duration(seconds: 1), () => Get.toNamed(home));
    } else {
      Future.delayed(const Duration(seconds: 1), () => Get.toNamed(login));
    }
  }
}
