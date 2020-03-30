import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  var txt;
  Result({this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(txt),
    );
  }
}