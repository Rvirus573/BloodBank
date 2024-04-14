import 'package:flutter/material.dart';

Widget customCard(
  String name
) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: Card(
      elevation: 3,
      shadowColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: Text(
          name,
          style: const TextStyle(fontSize: 25),
        ),
      ),
    ),
  );
}
