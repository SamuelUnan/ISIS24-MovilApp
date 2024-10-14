import 'package:flutter/material.dart';

class BackgroundHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
          0.2,
          0.8
        ],
            colors: [
          Color(0xffae92e0),
          Color(0xff7235e3),
        ]));
    return Container(decoration: boxDecoration);
  }
}
