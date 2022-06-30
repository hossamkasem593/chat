
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

class MyBotton extends StatelessWidget {
Color color;
String title;
final VoidCallback onPressed;
 MyBotton({required this.color,required this.title,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: color,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: MaterialButton(
        onPressed:  onPressed,
        minWidth: 200,
        height: 42,
        child: Text(title,style: TextStyle(color: Colors.white)),
        
        ),
      ),
    );
  }
}