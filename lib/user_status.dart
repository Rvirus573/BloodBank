import 'package:bloodbank/route/routes.dart';
import 'package:bloodbank/widget/custom_app_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late Stream<QuerySnapshot> userStream;
  FirebaseAuth userAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection("users");

  final _formkey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  int? user_value;

  String? categoryValue;
  int uservalue = 1;

  final storage = FirebaseStorage.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  //CollectionReference users = FirebaseFirestore.instance.collection('info');
  final users = FirebaseFirestore.instance.collection("users");
  //final userBloodReg = users.doc(users.id).collection("bloodRegistration");

  addDataBloodRegistration() {
    final user = auth.currentUser;
    var userId = user!.email.toString();
    try {
      // ignore: prefer_interpolation_to_compose_strings
      users.doc(userId).update({
        // John Doe
        "uservalue": uservalue,
      });

     // Fluttertoast.showToast(msg: "Succeess");
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  
  fetchDisplayName() async {
    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await firestore.doc(userAuth.currentUser!.email.toString()).get();
    //print(user_value);
    setState(() {});
    return user_value = userDoc['uservalue'];
  }

  @override
  void initState() {
  

    fetchDisplayName();
    super.initState();
  }

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
                const Color.fromARGB(144, 4, 112, 45),
                
                'assets/icon/in.png',
                "  User Status\n",
                " "),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    // customTextField(controllerEmail, "Email"),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: Text(
                        "Your Present Status in this App",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ToggleSwitch(
                      minWidth: 200.0,
                      initialLabelIndex: user_value,
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
                       // print("reza $uservalue");
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    InkWell(
                      onTap: () {
                        addDataBloodRegistration();

                        FocusManager.instance.primaryFocus?.unfocus();
                        //getCurrentUserDocumentId();
                        Get.toNamed(home);
                      },
                      child: Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(colors: [
                            Color(0xffB81736),
                            Color(0xff281537),
                          ]),
                        ),
                        child: const Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: Text(
                        "Note:\nBlood Donor: want to be a donate blood.\n\nGeneral User: Want to get information or receive Blood.",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
