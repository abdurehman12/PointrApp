import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String text;
  MyButton({super.key, required this.onTap, required this.text});

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: GestureDetector(
          // onTap: onTap,
          child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffffd89b), Color(0xff19547b)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            color: Colors.black,
            borderRadius: BorderRadius.circular(40)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.5),
              ),
            ),
            Icon(Icons.arrow_forward, color: Colors.white)
          ],
        ),
      )),
    );
  }
}
