import 'package:bloodbank/route/routes.dart';
import 'package:bloodbank/widget/custom_app_bar.dart';
import 'package:bloodbank/widget/custom_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController controllerEmail = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
        body: Column(
          children: [
            customAppBar(
                context,
                200,
                const Color(0xffB81736),
                const Color(0xff281537),
                'assets/icon/baiust.png',
                "Forgot Password",
                ""),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: customTextFormField(controllerEmail, "Email", (value) {
                if (EmailValidator.validate(controllerEmail.text)) {
                } else {
                  return "Please enter a valid email";
                }
                return null;
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      auth
                          .sendPasswordResetEmail(email: controllerEmail.text)
                          .then((value) {
                        Fluttertoast.showToast(
                            msg:
                                "We have sent you  to recover password, Please check your email");

                        FocusManager.instance.primaryFocus!.unfocus();
                        Get.toNamed(login);
                        controllerEmail.clear();
                      }).onError((error, stackTrace) {
                        Fluttertoast.showToast(msg: error.toString());
                      });

                      // Get.snackbar("success", "message");
                    } else {
                      Fluttertoast.showToast(
                          msg: " Invalid",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.green[900],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
