import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.obsecuretext,
      required this.characterlength,
      required this.icon});

  final controller;
  final String hint;
  final bool obsecuretext;
  final int characterlength;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    var hint2 = hint;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: TextField(
          maxLength: characterlength,
          controller: controller,
          obscureText: obsecuretext,
          decoration: InputDecoration(
            suffixIcon: icon,
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            // fillColor: Colors.white,
            // filled: true,
          ),
        ));
  }
}
