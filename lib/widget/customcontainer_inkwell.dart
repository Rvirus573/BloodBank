import 'package:flutter/material.dart';

Widget customContainerInkwell(ontap, String name) {
  return InkWell(
    onTap: ontap,
    child: Container(
        height: 88,
        width: 80,
        decoration: BoxDecoration(
            border: Border.all(),
            color: const Color(0xffB81736),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Center(
          child: Center(
              child: Text(
            name,
            style: const TextStyle(
                fontSize: 30, color: Color.fromARGB(255, 53, 2, 12)),
          )),
        )),
  );
}
