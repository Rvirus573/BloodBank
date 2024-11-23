import 'package:bloodbank/route/routes.dart';
import 'package:bloodbank/widget/custom_app_bar.dart';

import 'package:bloodbank/widget/custom_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  loginEmail() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: controllerEmail.text, password: controllerPassword.text);
      var authCredential = credential.user;
      if (authCredential!.uid.isNotEmpty) {
        Get.toNamed(home);
      } else {
        Get.snackbar('Error', 'Something is wrong');
        Fluttertoast.showToast(msg: "Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('user-not-found', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
            'wrong-password', 'Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: customAppBar(
                context,
                190,
             const Color.fromARGB(144, 4, 112, 45),
               
                'assets/icon/in.png',
                "BAIUST Blood Bank\n       Login",
                " "),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Form(
                  key: _formkey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Please enter Your email Number and Password",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customTextFormField(controllerEmail, "Email", (value) {
                        if (EmailValidator.validate(controllerEmail.text)) {
                        } else {
                          return "Please enter a valid email";
                        }
                        return null;
                      }, TextInputType.emailAddress),
                      const SizedBox(
                        height: 10,
                      ),
                      customTextFormField(controllerPassword, "Password",
                          (value) {
                        if (value == null || value.isEmpty) {
                          return "This Password field can not be  empty";
                        } else if (value.length < 8) {
                          return "Password must be 8 characters";
                        }
                        return null;
                      }, TextInputType.visiblePassword, true),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                loginEmail();

                                controllerEmail.clear();
                                controllerPassword.clear();
                                // Get.snackbar("success", "message");
                              } else {
                                Fluttertoast.showToast(
                                    msg: " Please enter your email and password ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.green[900],
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              text: TextSpan(
                                  text: 'Forgot Password',
                                  style: const TextStyle(
                                      color: Colors.blueAccent, fontSize: 20),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(forgotpassword);
                                    })),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                text: 'Don\'t have an account?',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' Sign up',
                                      style: const TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 20),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed(signup);
                                        })
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
