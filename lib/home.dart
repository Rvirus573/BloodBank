import 'package:bloodbank/route/routes.dart';
import 'package:bloodbank/widget/custom_inkwell.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Stream<QuerySnapshot> userStream =
      FirebaseFirestore.instance.collection('info').snapshots();

  final authUser = FirebaseAuth.instance;

  numberOfUser() {
    StreamBuilder<QuerySnapshot>(
      stream: userStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['name']),
              subtitle: Text(data['phone']),
            );
          }).toList(),
        );
      },
    );
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();

    Get.snackbar("Logout", "Successfully logged out ");
  }

  final List<Map<String, dynamic>> items = [
    {
      'name': 'Search Donor',
      'picture': 'assets/icon/bloodsearch.png',
    },
    {'name': 'Set Your Status', 'picture': 'assets/icon/bloodadd2.png'},
    {'name': 'Personal Profile', 'picture': 'assets/icon/profile.png'},
    {
      'name': 'Terms   &\nConditions',
      'picture': 'assets/icon/tac.png',
    },
    {
      'name': 'Information',
      'picture': 'assets/icon/info.png',
    },
    {
      'name': 'About',
      'picture': 'assets/icon/dev.png',
    },
    {
      'name': 'Feedback',
      'picture': 'assets/icon/feedback.png',
    },
    // Add more items as needed
  ];
  List link = [
    "search",
    "registration",
    "profile",
    "terms",
    "information",
    "about",
    "feedback",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 190,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                // image: DecorationImage(
                //     image: AssetImage('assets/icon/baiust.png',),
                //     fit: BoxFit.fill),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.elliptical(45, 30)),
                // gradient: LinearGradient(colors: [
                //   Color(0xffB81736),
                //   Color(0xff281537),
                // ], begin: Alignment.bottomCenter, end: Alignment.topCenter)
                color:  Color.fromARGB(144, 4, 112, 45),
                
                ),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/in.png',
                              height: 120,
                              width: 120,
                            ),
                            const Center(
                              child: Text(
                                " Donate Blood \n     Save Life",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            IconButton(
                              highlightColor: Colors.white,
                              color: Colors.red,
                                onPressed: () {
                                  signOut();
                                  Get.toNamed(login);
                                  
                                },
                                icon: const Icon(
                                  Icons.logout_outlined,
                                  weight: 30,
                                ))
                          ],
                        ),
                        Text("",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Colors.green[900])),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items in each row
                childAspectRatio: .96,
                mainAxisSpacing: 10.0, // spacing between rows
                crossAxisSpacing: 5.0, // spacing between columns
              ),
              padding: const EdgeInsets.all(8.0), // padding around the grid
              itemCount: items.length, // total number of items
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: customInkwell(
                      items[index]['picture'], items[index]['name'], () {
                    Get.toNamed(link[index]);
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
