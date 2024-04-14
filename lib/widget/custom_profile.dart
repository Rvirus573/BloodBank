// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget custom_profile(String name, String data, [ontap]) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        name,
        style: const TextStyle(fontSize: 20),
      ),
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Text(
              data,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          IconButton(onPressed: ontap, icon: const Icon(Icons.edit))
        ],
      ))
    ],
  );
}

Widget custom_profile2(
  String name,
  String data,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        name,
        style: const TextStyle(fontSize: 20),
      ),
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Text(
              data,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ))
    ],
  );
}
