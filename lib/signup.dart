// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'dart:async';

import 'package:bloodbank/route/routes.dart';
import 'package:bloodbank/widget/custom_app_bar.dart';
import 'package:bloodbank/widget/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:toggle_switch/toggle_switch.dart';

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
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerDepartment = TextEditingController();
  TextEditingController controllerBatch = TextEditingController();

  final firestore = FirebaseFirestore.instance.collection("users");

  final authUser = FirebaseAuth.instance;

  String? studentEmployye = "";

  bool positive = false;

  String? idUser;
  String? idBlood;
  String? formattedDate;

  DateTime currentDate = DateTime.now();
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

  // currentDateTime() {
  //   DateTime now = DateTime.now();
  //   formattedDate = DateFormat('dd/MM/yyyy').format(now);
  // }

  String? categoryValue;
  int uservalue = 1;

  // "name": controllerName.text,
  // "id": controllerID ,

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

  final List<String> nameList = <String>[
    "Student",
    "Alumni",
    "Employee",
  ];
  String? _value1;

  Future writeRegistrationdata() async {
    // String id = DateTime.now().millisecondsSinceEpoch.toString();

    idUser = controllerEmail.text;
    firestore.doc(idUser).set({
      "type": _value1.toString(),
      "name": controllerName.text,
      "studentid": controllerID.text,
      "email": controllerEmail.text,
      'bloodGroup': categoryValue, // Stokes and Sons
      "date": "",
      'Phone': "+88${controllerPhone.text}",
      'address': controllerAddress.text,
      "batch": controllerBatch.text,
      "department": controllerDepartment.text,
      "uservalue": uservalue,
    });
  }

  // ignore: non_constant_identifier_names
  bool Employee = true;

  @override
  void initState() {
    // currentDateTime();

    super.initState();
  }

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
                const Color.fromARGB(144, 4, 112, 45),
        
                'assets/icon/in.png',
                "BAIUST Blood Bank\n         Signup",
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
                            style:
                                TextStyle(fontSize: 15, color: Colors.black45)),
                        value: _value1,
                        onChanged: (value) {
                          setState(() {
                            _value1 = value as String?;

                            if (_value1 == "Employee") {
                              Employee = true;
                            } else {
                              Employee = false;
                            }
                            print(_value1);
                          });
                        },
                        items: nameList.map(
                          (item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          },
                        ).toList(),
                      ),

                      customTextFormField(controllerName, "Name", (value) {
                        if (value == null || value.isEmpty) {
                          return "This name field can not be  empty";
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 15,
                      ),
                      customTextFormField(
                          controllerID, "Student ID/ Empolyee ID", (value) {
                        if (_value1 == "Student" || _value1 == "Alumni") {
                          if (value == null || value.isEmpty) {
                            return "This ID can not be  empty";
                          }
                          // if (value.length != 7) {
                          //   return "This Student Id Can be 7 Digit";
                          // }

                          // if (value.contains(RegExp(r'^082'))) {
                          // } else {
                          //   return "Enter Valid Student Id";
                          // }
                        }
                        //else if (value!.length != 6) {
                        //   return "Employee Id Can be 6 Digit";
                        // }
                        if (value!.isEmpty) {
                          return "This field can not be  empty";
                        }

                        return null;
                      }, TextInputType.number),
                      const SizedBox(
                        height: 15,
                      ),
                      customTextFormField(controllerEmail, "Personal Email",
                          (value) {
                        if (EmailValidator.validate(controllerEmail.text)) {
                        } else {
                          return "Please enter a valid personal email";
                        }
                        return null;
                      }, TextInputType.emailAddress),
                      const SizedBox(
                        height: 15,
                      ),
                      customTextFormField(
                          controllerPassword, "Password for this app", (value) {
                        if (value == null || value.isEmpty) {
                          return "This Password field can not be  empty";
                        } else if (value.length < 8) {
                          return "Password must be 8 characters";
                        }
                        return null;
                      }, TextInputType.visiblePassword, true),

                      const SizedBox(
                        height: 30,
                      ),
                      // customTextField(controllerEmail, "Email")
                      Center(
                          child: Text(
                        "Your Present Status in this App",
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      ToggleSwitch(
                        minWidth: 200.0,
                        initialLabelIndex: 1,
                        cornerRadius: 20,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.black,
                        totalSwitches: 2,
                        labels: [
                          '  General User\nReceived Blood',
                          '    Blood Donor\nReceived & Donate'
                        ],
                        activeBgColors: [
                          [Colors.blue],
                          [Color(0xffB81736)]
                        ],
                        onToggle: (index) {
                          // print('switched to: $index');
                          uservalue = index!;
                          print("reza $uservalue");
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      DropdownButton(
                          underline: Container(
                            height: 1,
                            color: Colors
                                .grey, // Customize the color of the underline
                          ),
                          isExpanded: true,
                          hint: const Text('Select Blood category',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black45)),
                          value: categoryValue,
                          style: const TextStyle(
                            decorationColor: Colors
                                .black, // Customize the color of the underline
                            decorationThickness:
                                1, // Customize the thickness of the underline
                            decorationStyle: TextDecorationStyle
                                .solid, // Customize the style of the underline
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'A+',
                                child: Text('A+',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black))),
                            DropdownMenuItem(
                                value: 'A-',
                                child: Text('A-',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black))),
                            DropdownMenuItem(
                                value: 'B+',
                                child: Text('B+',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black))),
                            DropdownMenuItem(
                                value: 'B-',
                                child: Text('B-',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black))),
                            DropdownMenuItem(
                                value: 'O+',
                                child: Text('O+',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black))),
                            DropdownMenuItem(
                                value: 'O-',
                                child: Text('O-',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black))),
                            DropdownMenuItem(
                                value: 'AB+',
                                child: Text('AB+',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black))),
                            DropdownMenuItem(
                                value: 'AB-',
                                child: Text('AB-',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black))),
                          ],
                          onChanged: (val) {
                            setState(() {
                              categoryValue = val.toString();
                            });
                          }),

                      const SizedBox(
                        height: 10,
                      ),
                      customTextFormField(controllerPhone, "Phone Number",
                          (value) {
                        if (value == null || value.isEmpty) {
                          return "This Phone Number field can not be  empty";
                        } else if (value.length < 11) {
                          return "Phone Number must be 11 characters";
                        }
                        return null;
                      }),

                      const SizedBox(
                        height: 10,
                      ),

                      customTextFormField(controllerAddress, "Address",
                          (value) {
                        if (value == null || value.isEmpty) {
                          return "Address field can not be  empty";
                        }
                        return null;
                      }),

                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: !Employee,
                        child: customTextFormField(
                            controllerDepartment, "Department", (value) {
                          if (value == null || value.isEmpty) {
                            return "Department field can not be  empty";
                          }
                          return null;
                        }),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Visibility(
                        visible: !Employee,
                        child: customTextFormField(controllerBatch, "Batch",
                            (value) {
                          if (value == null || value.isEmpty) {
                            return "Batch field can not be  empty";
                          }
                          return null;
                        }),
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      customElevetedButton(
                          "Sign Up", const WidgetStatePropertyAll(Colors.green),
                          () {
                        if (_formkey.currentState!.validate()) {
                          signUpUser(context);
                          writeRegistrationdata();

                          controllerName.clear();
                          controllerID.clear();
                          studentEmployye = "";

                          controllerEmail.clear();

                          print("Id 1 : $idUser");
                          print("Id 2 : $idBlood");

                          Get.toNamed(home);

                          // Get.snackbar("success", "message");
                        } else {
                          Fluttertoast.showToast(
                              msg: " Please fillup all Fields ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }

                        // ignore: unrelated_type_equality_checks,
                        // if (_value1 == null ||
                        //     controllerName == null ||
                        //     controllerPassword == null ||
                        //     controllerID == null ||
                        //     controllerAddress == null ||
                        //     controllerEmail == null ||
                        //     controllerPhone == null ||
                        //     controllerPhone == null) {
                        //   Fluttertoast.showToast(
                        //       msg: "Please fillup all Fields");
                        // } else {

                        // }
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

                      const SizedBox(
                        height: 20,
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
