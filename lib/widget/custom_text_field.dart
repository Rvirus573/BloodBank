import 'package:flutter/material.dart';

Widget customTextField(controllername, hint) {
  return TextFormField(
    controller: controllername,
    decoration: InputDecoration(
      labelText: hint, focusColor: Colors.green,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.green),
      ),

      //   focusedBorder: InputBorder.none(),
    ),
  );
}

Widget customTextFormField(TextEditingController controller, String hint,
    String? Function(String?)? validation,[keybordtype, bool obscureText=false]) {
  return TextFormField(
    controller: controller,
    validator: validation,
    obscureText: obscureText ,
    keyboardType: keybordtype,
    decoration: InputDecoration(
      labelText: hint, focusColor: Colors.green,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.green),
      ),

      //   focusedBorder: InputBorder.none(),
    ),
  );
}

Widget customElevetedButton(name, WidgetStatePropertyAll<Color> color, onPress) {
  return SizedBox(
    width: 300,
    child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: color,
        ),
        onPressed: onPress,
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        )),
  );
}
