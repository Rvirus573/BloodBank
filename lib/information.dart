import 'package:bloodbank/dummy/dummy_text.dart';
import 'package:bloodbank/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
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
           
                'assets/icon/in.png',
                "   Blood \nInformation",
                ""),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "রক্ত দেয়া কেন প্রয়োজন?",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                  ReadMoreText(
                    Dummy.bloodInformation1,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "কারা রক্ত দিতে পারবেন?",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                  ReadMoreText(
                    Dummy.bloodInformation2,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "রক্ত দেয়ার পর কী হয়?",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                  ReadMoreText(
                    Dummy.bloodInformation3,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "কে কাকে রক্ত দিতে পারবে?",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                  Image.asset(
                    "assets/icon/bloodchart.png",
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "রক্ত দেয়ার উপকারিতা:",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                  ReadMoreText(
                    Dummy.bloodInformation4,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
