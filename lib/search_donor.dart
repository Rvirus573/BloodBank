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

  @override
  void initState() {
    userStream = FirebaseFirestore.instance.collection('users').snapshots();

    _fetchUsersCount();
    super.initState();
  }

  Future<void> _fetchUsersCount() async {
    QuerySnapshot usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    QuerySnapshot usersSnapshotA1 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'A+')
        .get();
    QuerySnapshot usersSnapshotA2 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'A-')
        .get();
    QuerySnapshot usersSnapshotB1 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'B+')
        .get();
    QuerySnapshot usersSnapshotB2 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'B-')
        .get();
    QuerySnapshot usersSnapshotO1 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'O+')
        .get();
    QuerySnapshot usersSnapshotO2 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'O-')
        .get();
    QuerySnapshot usersSnapshotAB1 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'AB+')
        .get();
    QuerySnapshot usersSnapshotAB2 = await FirebaseFirestore.instance
        .collection('users')
        .where('bloodGroup', isEqualTo: 'AB-')
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
                const Color(0xffB81736),
                  const Color(0xff281537),
                'assets/icon/baiust.png',
                "    Search\nBlood Donor",
                "rezaul"),
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
                        userStream = FirebaseFirestore.instance
                            .collection('users')
                            .where("bloodGroup", isEqualTo: "B-")
                            .snapshots();
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
                                                    Positioned(
                                                        top: -25,
                                                        child: Image.asset(
                                                            "assets/icon/profilesee.png",
                                                            width: 150,
                                                            height: 150))
                                                  ],
                                                ));
                                          });
                                        });
                                  },
                                  child: Container(
                                    height: 120,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(),
                                      child: Row(
                                        children: [
                                          Center(
                                              child: Text(
                                            data["bloodGroup"],
                                            style: const TextStyle(
                                                fontSize: 30,
                                                color:  Color(0xffB81736),),
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
                                                  child: Text(
                                                    "Nmae : ${data['name']}",
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                Text(
                                                  "Department : ${data['department']}",
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  "Batch : ${data['batch']}",
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                              ],
                                            ),
                                          ),
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
                                                      await launchUrl(url);
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
                                  ),
                                ),
                              ),
                            )

                            // ListTile(
                            //   leading: Container(
                            //     height: 50,
                            //     width: 50,
                            //     color: Colors.pink,
                            //   ),
                            //   title: Text(data['name']),
                            //   subtitle: Text(data['phone']),
                            // ),
                            ),
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
