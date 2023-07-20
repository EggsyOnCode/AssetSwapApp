import 'package:flutter/material.dart';
ElevatedButton CustomButton(Size size, String text) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        fixedSize: Size.fromWidth(size.width * 0.6),
        backgroundColor: Color.fromARGB(255, 0, 70, 181)),
    onPressed: () {
      // final provider = Provider.of(context, ) 
    },
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
  );
}
