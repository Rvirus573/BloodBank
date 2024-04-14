// ignore_for_file: non_constant_identifier_names

import 'package:bloodbank/widget/custom_app_bar.dart';
import 'package:bloodbank/widget/custom_profile.dart';
import 'package:bloodbank/widget/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Stream<QuerySnapshot> userStream;
  FirebaseAuth userAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection("users");
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerLocation = TextEditingController();
  TextEditingController controllerDate = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String displayname = "";
  String date = "";
  String name = "";

  fetchDisplayName() async {
    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await firestore.doc(userAuth.currentUser!.email.toString()).get();

    return name = userDoc['name'];
  }

  Future<void> pickDate(context) async {
    final pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    date = " ${pickDate?.day}/${pickDate?.month}/${pickDate?.year}";
    UpadateProfileDate();
    setState(() {});
  }

  Future UpadateProfilePhone() async {
    // String id = DateTime.now().millisecondsSinceEpoch.toString();

    firestore.doc(userAuth.currentUser!.email.toString()).update({
      "Phone": "+88${controllerPhone.text}",
    });

    Fluttertoast.showToast(msg: "Successfully Update");
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future UpadateProfileLocation() async {
    // String id = DateTime.now().millisecondsSinceEpoch.toString();

    firestore.doc(userAuth.currentUser!.email.toString()).update({
      "address": controllerLocation.text,
    });

    Fluttertoast.showToast(msg: "Successfully Update");
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future UpadateProfileDate() async {
    // String id = DateTime.now().millisecondsSinceEpoch.toString();

    firestore.doc(userAuth.currentUser!.email.toString()).update({
      "date": date,
    });

    Fluttertoast.showToast(msg: "Successfully Update");
    //FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void initState() {
    userStream = FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: userAuth.currentUser!.email.toString())
        .snapshots();

    fetchDisplayName();
    Future.delayed(
        const Duration(seconds: 1),
        () => setState(() {
              name;
            }));
    setState(() {
      name;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
        body: SafeArea(
          child: Column(children: [
            customAppBar(
                context,
                200,
                const Color(0xffB81736),
                const Color(0xff281537),
                'assets/icon/baiust.png',
                "Profile Update",
                "   $name"),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: userStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;

                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            custom_profile(
                              "Name: ",
                              "${data['name']}",
                            ),
                            const Divider(),
                            custom_profile(
                              "Department: ",
                              "${data['department']}",
                            ),
                            const Divider(),
                            custom_profile(
                              "Batch: ",
                              "${data['batch']}",
                            ),
                            const Divider(),
                            custom_profile("Phone: ", "${data['Phone']}", () {
                              showDialog(
                                context: context,
                                builder: (ctx) => SizedBox(
                                  height: 500,
                                  child: AlertDialog(
                                    title: const Text("Update Phone Number",
                                        style: TextStyle(fontSize: 20)),
                                    actions: [
                                      customTextFormField(
                                          controllerPhone, "11 Digit Number",
                                          (value) {
                                        if (value == null || value.isEmpty) {
                                          return "This Password field can not be  empty";
                                        } else if (value.length < 11) {
                                          return "Password must be 11 characters";
                                        }
                                        return null;
                                      }),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      customElevetedButton(
                                          "Update",
                                          const MaterialStatePropertyAll(
                                              Colors.green), () {
                                        UpadateProfilePhone();
                                        Get.back();
                                      })
                                    ],
                                  ),
                                ),
                              );
                            }),
                            const Divider(),
                            custom_profile(
                              "Blood Group: ",
                              "${data['bloodGroup']}",
                            ),
                            const Divider(),
                            custom_profile(
                              "Email: ",
                              "${data['email']}",
                            ),
                            const Divider(),
                            custom_profile(
                                "Current Location:  ", "${data['address']}",
                                () {
                              showDialog(
                                context: context,
                                builder: (ctx) => SizedBox(
                                  height: 500,
                                  width: double.infinity,
                                  child: AlertDialog(
                                    title: const Text("Update Current Location",
                                        style: TextStyle(fontSize: 20)),
                                    actions: [
                                      customTextFormField(
                                          controllerLocation, "Location ",
                                          (value) {
                                        return null;
                                      }),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      customElevetedButton(
                                          "Update",
                                          const MaterialStatePropertyAll(
                                              Colors.green), () {
                                        UpadateProfileLocation();
                                        Get.back();
                                      })
                                    ],
                                  ),
                                ),
                              );
                            }),
                            const Divider(),
                            custom_profile(
                              "User: ",
                              "${data['type']}",
                            ),
                            const Divider(),
                            custom_profile(
                              "Id: ",
                              "${data['studentid']}",
                            ),
                            const Divider(),
                            custom_profile("Last Donate: ", "${data['date']}",
                                () {
                              pickDate(context);
                              setState(() {});
                            }),
                            const Divider(),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
