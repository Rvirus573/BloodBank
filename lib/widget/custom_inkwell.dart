import 'package:flutter/material.dart';

Widget customInkwell(String image, String name, ontap) {
  return InkWell(
    onTap: ontap,
    child: SizedBox(
      height: 170,
      width: 160,
      child: Card(
        elevation: 3,
        shadowColor: Colors.red,
        color: const Color.fromARGB(255, 207, 233, 223),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 65,
                width: 70,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.green[600])),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
