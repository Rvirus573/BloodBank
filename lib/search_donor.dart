// ignore_for_file: sized_box_for_whitespace

import 'package:bloodbank/route/routes.dart';
import 'package:bloodbank/widget/custom_app_bar.dart';
import 'package:bloodbank/widget/custom_profile.dart';
import 'package:bloodbank/widget/customcontainer_inkwell.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchDonor extends StatefulWidget {
  const SearchDonor({super.key});

  @override
  State<SearchDonor> createState() => _SearchDonorState();
}

class _SearchDonorState extends State<SearchDonor> {
  late Stream<QuerySnapshot> userStream;
  final firestore = FirebaseFirestore.instance.collection("users");
  FirebaseAuth userAuth = FirebaseAuth.instance;
  int _numberOfUsers = 0;
  int _numberOfUsersA1 = 0;
  int _numberOfUsersA2 = 0;
  int _numberOfUsersB1 = 0;
  int _numberOfUsersB2 = 0;
  int _numberOfUsersO1 = 0;
  int _numberOfUsersO2 = 0;
  int _numberOfUsersAB1 = 0;
  int _numberOfUsersAB2 = 0;

  // ignore: prefer_typing_uninitialized_variables
  //var lastdonateDate;

  //int? _daysDifference;
  DateTime? startDate;
  String d = "";

  // Function to select a start date

  // Function to calculate the difference between the start date and the current date
  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  // int? _calculateDifference(BuildContext, lastdonateDate) {
  //   DateFormat format = DateFormat("dd/MM/yyyy");
  //   startDate = format.parse(lastdonateDate);
  //   print(startDate);

  //   DateTime currentDate = DateTime.now();
  //   _daysDifference = currentDate.difference(startDate!).inDays;

  //   return _daysDifference;
  // }

  @override
  void initState() {
    userStream = FirebaseFirestore.instance.collection('users').snapshots();

    // last_Donate_Date();
    _fetchUsersCount();

    // Future.delayed(
    //     const Duration(seconds: 2),
    //     () => setState(() {
    //          // print("date check 22 ${lastdonateDate.toString()}");

    //           _calculateDifference(context, lastdonateDate);
    //         }));

    super.initState();
  }

  Future<void> _fetchUsersCount() async {
    QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uservalue', isEqualTo: 1)
        .get();

    QuerySnapshot usersSnapshotA1 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'A+')
        .where('uservalue', isEqualTo: 1)
        .get();
    QuerySnapshot usersSnapshotA2 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'A-')
        .where('uservalue', isEqualTo: 1)
        .get();
    QuerySnapshot usersSnapshotB1 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'B+')
        .where('uservalue', isEqualTo: 1)
        .get();
    QuerySnapshot usersSnapshotB2 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'B-')
        .where('uservalue', isEqualTo: 1)
        .get();
    QuerySnapshot usersSnapshotO1 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'O+')
        .where('uservalue', isEqualTo: 1)
        .get();
    QuerySnapshot usersSnapshotO2 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'O-')
        .where('uservalue', isEqualTo: 1)
        .get();
    QuerySnapshot usersSnapshotAB1 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'AB+')
        .where('uservalue', isEqualTo: 1)
        .get();
    QuerySnapshot usersSnapshotAB2 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'AB-')
        .where('uservalue', isEqualTo: 1)
        .get();

    setState(() {
      _numberOfUsers = usersSnapshot.size;
      _numberOfUsersA1 = usersSnapshotA1.size;
      _numberOfUsersA2 = usersSnapshotA2.size;
      _numberOfUsersB1 = usersSnapshotB1.size;
      _numberOfUsersB2 = usersSnapshotB2.size;
      _numberOfUsersO1 = usersSnapshotO1.size;
      _numberOfUsersO2 = usersSnapshotO2.size;
      _numberOfUsersAB1 = usersSnapshotAB1.size;
      _numberOfUsersAB2 = usersSnapshotAB2.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            customAppBar(
                context,
                200,
               const Color.fromARGB(144, 4, 112, 45),
              
                'assets/icon/in.png',
                "    Search\nBlood Donor",
                ""),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    customContainerInkwell(() {
                      setState(() {
                        userStream = FirebaseFirestore.instance
                            .collection('users')
                            .snapshots();
                      });
                    }, "All\n$_numberOfUsers"),
                    const SizedBox(
                      width: 10,
                    ),
                    customContainerInkwell(() {
                      setState(() {
                        userStream = FirebaseFirestore.instance
                            .collection('users')
                            .where("bloodGroup", isEqualTo: "A+")
                            .snapshots();
                      });
                      //.where("BloodGroup", isEqualTo: "A+");
                    }, "A+\n$_numberOfUsersA1"),
                    const SizedBox(
                      width: 10,
                    ),
                    customContainerInkwell(() {
                      setState(() {
                        userStream = FirebaseFirestore.instance
                            .collection('users')
                            .where("bloodGroup", isEqualTo: "A-")
                            .snapshots();
                      });
                    }, "A-\n$_numberOfUsersA2"),
                    const SizedBox(
                      width: 10,
                    ),
                    customContainerInkwell(() {
                      setState(() {
                        userStream = FirebaseFirestore.instance
                            .collection('users')
                            .where("bloodGroup", isEqualTo: "B+")
                            .snapshots();
                      });
                    }, "B+\n$_numberOfUsersB1"),
                    const SizedBox(
                      width: 10,
                    ),
                    customContainerInkwell(() {
                      setState(() {
                        _numberOfUsersB2 > 0 ?
                        
                        userStream = FirebaseFirestore.instance
                            .collection('users')
                            .where("bloodGroup", isEqualTo: "B-")
                            .snapshots():Center(
                            
                              child: Text("No Data")); 
                      });
                    }, "B-\n$_numberOfUsersB2"),
                    const SizedBox(
                      width: 10,
                    ),
                    customContainerInkwell(() {
                    
                      setState(() {
                        userStream = FirebaseFirestore.instance
                            .collection('users')
                            .where("bloodGroup", isEqualTo: "O+")
                            .snapshots();
                      });
                    }, "O+\n$_numberOfUsersO1"),
                    const SizedBox(
                      width: 10,
                    ),
                    customContainerInkwell(() {
                     
                      setState(() {
                        userStream = FirebaseFirestore.instance
                            .collection('users')
                            .where("bloodGroup", isEqualTo: "O-")
                            .snapshots();
                      });
                    }, "O-\n$_numberOfUsersO2"),
                    const SizedBox(
                      width: 10,
                    ),
                    customContainerInkwell(() {
                      setState(() {
                        userStream = FirebaseFirestore.instance
                            .collection('users')
                            .where("bloodGroup", isEqualTo: "AB+")
                            .snapshots();
                      });
                    }, "AB+\n$_numberOfUsersAB1"),
                    const SizedBox(
                      width: 10,
                    ),
                    customContainerInkwell(
                      () {
                        setState(() {
                          userStream = FirebaseFirestore.instance
                              .collection('users')
                              .where("bloodGroup", isEqualTo: "AB-")
                              .snapshots();
                        });
                      },
                      "AB-\n$_numberOfUsersAB2",
                    ),
                  ],
                ),
              ),
            ),
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

                      //  DateFormat format = DateFormat("d/m/yyyy");
                    //  lastdonateDate = data['date'];

                      //startDate = format.parse(lastdonateDate);
                      if (data['uservalue'] == 1) {}
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Card(
                            elevation: 3,
                            shadowColor: Colors.grey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(registration);
                                },
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (_, setState) {
                                            return Dialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                insetPadding:
                                                    const EdgeInsets.all(10),
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  alignment: Alignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      width: double.infinity,
                                                      height: 600,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: Colors.white),
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          20, 70, 20, 20),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 50,
                                                          ),
                                                          custom_profile2(
                                                            "Name: ",
                                                            "${data['name']}",
                                                          ),
                                                          const Divider(),
                                                          custom_profile2(
                                                            "Department: ",
                                                            "${data['department']}",
                                                          ),
                                                          const Divider(),
                                                          custom_profile2(
                                                            "Batch: ",
                                                            "${data['batch']}",
                                                          ),
                                                          const Divider(),
                                                          custom_profile2(
                                                            "Phone: ",
                                                            "${data['Phone']}",
                                                          ),
                                                          const Divider(),
                                                          custom_profile2(
                                                            "Blood Group: ",
                                                            "${data['bloodGroup']}",
                                                          ),
                                                          const Divider(),
                                                          custom_profile2(
                                                            "Current Location:  ",
                                                            "${data['address']}",
                                                          ),
                                                          const Divider(),
                                                          custom_profile2(
                                                            "User: ",
                                                            "${data['type']}",
                                                          ),
                                                          const Divider(),
                                                          custom_profile2(
                                                            "Last Donate: ",
                                                            "${data['date']}",
                                                          ),
                                                          userAuth.currentUser!
                                                                      .email
                                                                      .toString() ==
                                                                  data["email"]
                                                              ? Center(
                                                                  child:
                                                                      IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.toNamed(
                                                                        profile);
                                                                  },
                                                                  icon: Image
                                                                      .asset(
                                                                    "assets/icon/dev.png",
                                                                    width: 40,
                                                                    height: 40,
                                                                  ),
                                                                ))
                                                              : const Center()
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                          });
                                        });
                                  },
                                  child: data["uservalue"] == 1
                                      ? Container(
                                          height: 140,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(),
                                            child: Row(
                                              children: [
                                                Center(
                                                    child: Text(
                                                  data["bloodGroup"].toString(),
                                                  style: const TextStyle(
                                                    fontSize: 30,
                                                    color: Color(0xffB81736),
                                                  ),
                                                )),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: FittedBox(
                                                        child: Text(
                                                          "Name : ${data["name"]}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    FittedBox(
                                                      child: Text(
                                                        "Location : ${data["address"]}",
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    
                                                    FittedBox(
                                                      child: Text(
                                                        "Last Donate : ${data["date"]}",
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),


                                                    // FittedBox(
                                                    //   child: Text(
                                                    //     "Last Donate : ${data["date"]} - ${_calculateDifference(context, data["date"]).toString()} Days",
                                                    //     style: const TextStyle(
                                                    //         fontSize: 16),
                                                    //   ),
                                                    // ),

                                                    // _calculateDifference(
                                                    //             context,
                                                    //             data[
                                                    //                 "date"])! >=
                                                    //         90
                                                    //     ? FittedBox(
                                                    //         child: Row(
                                                    //           children: [
                                                    //             Text(
                                                    //               // "Available : ${_daysDifference.toString()}",
                                                    //               " Available for Donate",

                                                    //               style: const TextStyle(
                                                    //                   fontSize:
                                                    //                       16,
                                                    //                   color: Colors
                                                    //                       .green),
                                                    //             )
                                                    //           ],
                                                    //         ),
                                                    //       )
                                                    //     : FittedBox(
                                                    //         child: Row(
                                                    //           children: [
                                                    //             Text(
                                                    //               // "Available : ${_daysDifference.toString()}",
                                                    //               "Not Available for Donate",

                                                    //               style: const TextStyle(
                                                    //                   fontSize:
                                                    //                       16,
                                                    //                   color: Colors
                                                    //                       .red),
                                                    //             )
                                                    //           ],
                                                    //         ),
                                                    //       ),

                                                    // ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                  ],
                                                )),
                                                Wrap(
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                      width: 50,
                                                      child: IconButton(
                                                        onPressed: () async {
                                                          final Uri url = Uri(
                                                            scheme: "tel",
                                                            path: data["Phone"],
                                                          );
                                                          if (await canLaunchUrl(
                                                              url)) {
                                                            await launchUrl(
                                                                url);
                                                          } else {
                                                            // ignore: avoid_print
                                                            print(
                                                                "something went wrong");
                                                          }

                                                          //  canLaunchUrl(Uri(scheme: 'tel', path: '123'));
                                                        },
                                                        icon: Image.asset(
                                                            'assets/icon/telephone.png'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Center(),
                                ),
                              ),
                            )),
                      );
                    }).toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
