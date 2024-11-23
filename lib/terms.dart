import 'package:bloodbank/dummy/dummy_text.dart';
import 'package:bloodbank/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
                children: [
          customAppBar(
              context,
              200,
              const Color.fromARGB(144, 4, 112, 45),
            //  const Color(0xff281537),
              'assets/icon/in.png',
              "   Terms  & \n Conditions",
              ""),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Text(
                  Dummy.terms1,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  Dummy.terms2,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  Dummy.terms3,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  Dummy.terms4,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  Dummy.terms5,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          )
                ],
              ),
        ));
  }
}
