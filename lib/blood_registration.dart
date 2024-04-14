import 'package:bloodbank/route/routes.dart';
import 'package:bloodbank/widget/custom_app_bar.dart';
import 'package:bloodbank/widget/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController controllerDepartment = TextEditingController();
  TextEditingController controllerBatch = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  String? categoryValue;

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
        'bloodGroup': categoryValue, // Stokes and Sons
        'date': "",
        'Phone': "+88${controllerPhone.text}",
        'address': controllerAddress.text,
        "batch": controllerBatch.text,
        "department": controllerDepartment.text,
      });

      Fluttertoast.showToast(msg: "Succeess");
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<String> getCurrentUserDocumentId() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final String uid = user!.email.toString();
    // ignore: avoid_print
    print("current user id : $uid");

    QuerySnapshot querySnapshot = await users
        // Replace 'users' with your collection name
        .where('uid', isEqualTo: uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Assuming there's only one document for each user
      //  return querySnapshot.docs.first.id;
      // ignore: avoid_print
      print(uid);
      return uid;
    } else {
      // Handle the case where the document for the user is not found
      return 'Document not found';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            customAppBar(
                context,
                200,
               const Color(0xffB81736),
                  const Color(0xff281537),
                'assets/icon/baiust.png',
                "Registration for\nBlood Donation",
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
                      padding: const EdgeInsets.only(left: 10),
                      child: DropdownButton(
                          isExpanded: true,
                          hint: const Text('Select Blood category',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black45)),
                          value: categoryValue,
                          items: const [
                            DropdownMenuItem(
                                value: 'A+',
                                child: Text('A+',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.red))),
                            DropdownMenuItem(
                                value: 'A-',
                                child: Text('A-',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.red))),
                            DropdownMenuItem(
                                value: 'B+',
                                child: Text('B+',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.red))),
                            DropdownMenuItem(
                                value: 'B-',
                                child: Text('B-',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.red))),
                            DropdownMenuItem(
                                value: 'O+',
                                child: Text('O+',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.red))),
                            DropdownMenuItem(
                                value: 'O-',
                                child: Text('O-',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.red))),
                            DropdownMenuItem(
                                value: 'AB+',
                                child: Text('AB+',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.red))),
                            DropdownMenuItem(
                                value: 'AB-',
                                child: Text('AB-',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.red))),
                          ],
                          onChanged: (val) {
                            setState(() {
                              categoryValue = val.toString();
                            });
                          }),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    customTextFormField(controllerPhone, "Phone Number",
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

                    customTextFormField(controllerAddress, "Address", (value) {
                      if (value == null || value.isEmpty) {
                        return "Address field can not be  empty";
                      }
                      return null;
                    }),

                    const SizedBox(
                      height: 10,
                    ),
                    customTextFormField(controllerDepartment, "Department",
                        (value) {
                      if (value == null || value.isEmpty) {
                        return "Department field can not be  empty";
                      }
                      return null;
                    }),

                    const SizedBox(
                      height: 10,
                    ),
                    customTextFormField(controllerBatch, "Batch", (value) {
                      if (value == null || value.isEmpty) {
                        return "Batch field can not be  empty";
                      }
                      return null;
                    }),

                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                        onPressed: () {
                          addDataBloodRegistration();
                          controllerAddress.clear();
                          controllerPhone.clear();
                          controllerDepartment.clear();
                          controllerBatch.clear();
                          categoryValue = null;

                          FocusManager.instance.primaryFocus?.unfocus();
                          //getCurrentUserDocumentId();
                          Get.toNamed(home);
                        },
                        child: const Text("Submit")),
                  ],
                ),
              ),
            ))
          ],
        )),
      ),
    );
  }
}
