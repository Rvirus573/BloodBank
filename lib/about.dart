import 'package:bloodbank/dummy/dummy_text.dart';
import 'package:bloodbank/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
 





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: customAppBar(
                context,
                200,
                const Color.fromARGB(144, 4, 112, 45),
               
                'assets/icon/in.png',
                "About \nDeveloper",
                ""),
          ),
          
          SizedBox(height: 30,),

  
          // Center(
          //   child: Image.asset(
          //     "assets/icon/homelogo.png",
          //     height: 190,
          //     width: 200,
          //   ),
          // ),
          const Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Center(
                child: Text(
              "Our Mission",
              strutStyle: StrutStyle(fontSize: 30),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 110, 3, 3)),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              Dummy.mission,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Center(
                child: Text(
              "About Developer",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 110, 3, 3)),
            )),
          ),
          const Center(
              child: Text(
            "Md. Zahid Hasan Buiyan",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 23, 5, 85)),
          )),
          const Center(
              child: Text(
            "Department of EEE",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 23, 5, 85)),
          )),
          const Center(
              child: Text(
            "Batch : 11",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 23, 5, 85)),
          )),
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Center(
                child: Text(
              "Contact Us",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 110, 3, 3)),
            )),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mail),
              Center(
                  child: Text(
                " mdzahidhasasan@gmail.com",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 23, 5, 85)),
              )),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              "  powered by Department of EEE, BAIUST ",
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ],
      ),
    ));
  }
}
