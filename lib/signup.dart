// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bloodbank/route/routes.dart';
import 'package:bloodbank/widget/custom_app_bar.dart';
import 'package:bloodbank/widget/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerID = TextEditingController();

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  final firestore = FirebaseFirestore.instance.collection("users");

  final authUser = FirebaseAuth.instance;

  String? studentEmployye;
  bool positive = false;

  String? idUser;
  String? idBlood;

  final _formkey = GlobalKey<FormState>();

  progressDailog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // "name": controllerName.text,
  //                             "id": controllerID ,

  signUpUser(BuildContext context) async {
    try {
      authUser.createUserWithEmailAndPassword(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future writeRegistrationdata() async {
    // String id = DateTime.now().millisecondsSinceEpoch.toString();
      
    idUser = controllerEmail.text;
    firestore.doc(idUser).set({
      "type": studentEmployye.toString(),
      "name": controllerName.text,
      "studentid": controllerID.text,
      "email": controllerEmail.text,
      'bloodGroup': "", // Stokes and Sons
      'date': "",
      'Phone': "",
      'address': "",
      "batch": "",
      "department": "",
      
    });

    

    
  }
 

//   Future phoneAuth(String phoneNumber, context) async {
//     final TextEditingController otpController = TextEditingController();
//     FirebaseAuth auth = FirebaseAuth.instance;

//     if (kIsWeb) {
//       try {
//         ConfirmationResult confirmationResult =
//             await auth.signInWithPhoneNumber(phoneNumber);
//         showDialog(
//             context: context,
//             builder: (_) {
//               return Dialog(
//                 child: SafeArea(
//                   child: SizedBox(
//                     height: 400,
//                     width: MediaQuery.of(context).size.width / 2,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         PinCodeTextField(
//                           autofocus: true,
//                           controller: otpController,
//                           hideCharacter: true,
//                           highlight: true,
//                           highlightColor: Colors.purple,
//                           defaultBorderColor: Colors.blue,
//                           hasTextBorderColor: Colors.transparent,
//                           highlightPinBoxColor: Colors.transparent,
//                           maxLength: 6,
//                           pinBoxWidth: 35,
//                           pinBoxHeight: 45,
//                           pinBoxRadius: 10,
//                           hasUnderline: true,
//                           wrapAlignment: WrapAlignment.spaceAround,
//                           pinBoxDecoration:
//                               ProvidedPinBoxDecoration.defaultPinBoxDecoration,
//                           pinTextStyle: const TextStyle(fontSize: 22.0),
//                           pinTextAnimatedSwitcherTransition:
//                               ProvidedPinBoxTextAnimation.scalingTransition,
// //                    pinBoxColor: Colors.green[100],
//                           pinTextAnimatedSwitcherDuration:
//                               const Duration(milliseconds: 300),
// //                    highlightAnimation: true,
//                           highlightAnimationBeginColor: Colors.black,
//                           highlightAnimationEndColor: Colors.white12,
//                           keyboardType: TextInputType.number,
//                         ),
//                         ElevatedButton(
//                           onPressed: () async {
//                             try {
//                               UserCredential userCredential =
//                                   await confirmationResult.confirm(
//                                 otpController.text,
//                               );
//                               if (userCredential.user != null) {
//                                 //    print('Success');

//                                 Get.toNamed(home);
//                               } else {
//                                 //      print('Failed');
//                                 Navigator.pop(context);
//                               }
//                             } catch (e) {
//                               //        print('Failed! Try Again.');
//                               Navigator.pop(context);
//                             }
//                           },
//                           child: const Text('continue'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             });
//       } catch (e) {
//         //     print('Something is wrong');
//       }
//     } else {
//       try {
//         await auth.verifyPhoneNumber(
//           phoneNumber: phoneNumber,
//           verificationCompleted: (PhoneAuthCredential credential) async {
//             var result = await auth.signInWithCredential(credential);
//             User? user = result.user;
//             if (user!.uid.isNotEmpty) {
//               Get.toNamed(home);
//             }
//           },
//           verificationFailed: (FirebaseAuthException e) async {
//             if (e.code == 'invalid-phone-number') {
//               //   print("The provided phone number is not valid.");
//             }
//           },
//           codeSent: (String verificationId, int? resendToken) async {
//             return showDialog(
//                 context: context,
//                 builder: (_) {
//                   return Dialog(
//                     child: SafeArea(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: SizedBox(
//                           height: 300,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               PinCodeTextField(
//                                 autofocus: true,
//                                 controller: otpController,
//                                 hideCharacter: true,
//                                 highlight: true,
//                                 highlightColor: Colors.purple,
//                                 defaultBorderColor: Colors.blue,
//                                 hasTextBorderColor: Colors.green,
//                                 highlightPinBoxColor: Colors.transparent,
//                                 maxLength: 6,
//                                 pinBoxWidth: 35,
//                                 pinBoxHeight: 45,
//                                 pinBoxRadius: 10,
//                                 hasUnderline: true,
//                                 wrapAlignment: WrapAlignment.spaceAround,
//                                 pinBoxDecoration: ProvidedPinBoxDecoration
//                                     .defaultPinBoxDecoration,
//                                 pinTextStyle: const TextStyle(fontSize: 22.0),
//                                 pinTextAnimatedSwitcherTransition:
//                                     ProvidedPinBoxTextAnimation
//                                         .scalingTransition,
// //                    pinBoxColor: Colors.green[100],
//                                 pinTextAnimatedSwitcherDuration:
//                                     const Duration(milliseconds: 300),
// //                    highlightAnimation: true,
//                                 highlightAnimationBeginColor: Colors.black,
//                                 highlightAnimationEndColor: Colors.white12,
//                                 keyboardType: TextInputType.number,
//                               ),
//                               ElevatedButton(
//                                 onPressed: () async {
//                                   try {
//                                     PhoneAuthCredential phoneCredential =
//                                         PhoneAuthProvider.credential(
//                                       verificationId: verificationId,
//                                       smsCode: otpController.text,
//                                     );
//                                     var result = await FirebaseAuth.instance
//                                         .signInWithCredential(phoneCredential);
//                                     User? user = result.user;
//                                     if (user != null) {
//                                       Navigator.pop(context);
//                                       print("Success");
//                                       Get.toNamed(home);

//                                       final box = GetStorage();
//                                       box.write("login_true", true);
//                                     } else {
//                                       print("Failed");
//                                       Navigator.pop(context);
//                                     }
//                                   } catch (e) {
//                                     print("Failed! Try Again.");
//                                     Navigator.pop(context);
//                                   }
//                                 },
//                                 child: const Text('Verify'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 });
//           },
//           codeAutoRetrievalTimeout: (String verificationId) async {},
//           timeout: const Duration(seconds: 60),
//         );
//       } catch (e) {
//         //print('Something is wrong');
//       }
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            customAppBar(
                context,
                190,
                const Color.fromARGB(255, 247, 2, 116),
                const Color.fromARGB(255, 6, 247, 135),
                'assets/icon/baiust.png',
                "     Signup",
                " "),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DropdownButton(
                          isExpanded: true,
                          hint: const Text('Are You ?',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black45)),
                          value: studentEmployye,
                          items: const [
                            DropdownMenuItem(
                                value: 'Student',
                                child: Text('Student',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.red))),
                            DropdownMenuItem(
                                value: 'Employee',
                                child: Text('Employee',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.red))),
                            DropdownMenuItem(
                                value: 'Alumni',
                                child: Text('Alumni',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.red))),
                          ],
                          onChanged: (val) {
                            setState(() {
                              studentEmployye = val.toString();
                            });
                          }),
                      customTextFormField(controllerName, "Name", (value) {
                        if (value == null || value.isEmpty) {
                          return "This Password field can not be  empty";
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 15,
                      ),
                      customTextFormField(controllerID, "Id Number", (value) {
                        if (studentEmployye == "Student") {
                          if (value!.contains(RegExp(r'^082'))) {
                            if (value.length != 5) {
                              return "Enter 11 digit Student Id";
                            }
                          } else {
                            return "Enter Valid Student Id";
                          }
                        } else if (studentEmployye == "Employee" &&
                            value!.length != 8) {
                        } else if (studentEmployye == "Alumni") {
                          if (value!.contains(RegExp(r'^082'))) {
                            if (value.length != 4) {
                              return "Enter 11 digit Student Id";
                            }
                          } else {
                            return "Enter Valid Student Id";
                          }
                        }
                        return null;
                      }, TextInputType.number),
                      const SizedBox(
                        height: 15,
                      ),
                      customTextFormField(controllerEmail, "Email", (value) {
                        if (EmailValidator.validate(controllerEmail.text)) {
                        } else {
                          return "Please enter a valid email";
                        }
                        return null;
                      }, TextInputType.emailAddress),
                      const SizedBox(
                        height: 15,
                      ),
                      customTextFormField(controllerPassword, "Password",
                          (value) {
                        if (value == null || value.isEmpty) {
                          return "This Password field can not be  empty";
                        } else if (value.length < 8) {
                          return "Password must be 8 characters";
                        }
                        return null;
                      }, TextInputType.visiblePassword,true),
                      const SizedBox(
                        height: 15,
                      ),
                      customElevetedButton("Sign Up",
                          const MaterialStatePropertyAll(Colors.green), () {
                        //  var number = "+88${controllerPhone.text}";
                        //  phoneAuth(number, context);

                        signUpUser(context);
                        writeRegistrationdata();

                        
                        
                        controllerName.clear();
                        controllerID.clear();
                        studentEmployye = "";

                        controllerEmail.clear();

                        print("Id 1 : $idUser");
                        print("Id 2 : $idBlood");

                        Get.toNamed(home);
                      }),

                       const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                text: 'Have an account?',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' Login',
                                      style: const TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 20),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed(login);
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
          ],
        ),
      ),
    );
  }
}
