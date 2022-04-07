import 'package:flutter/material.dart';
//Techie Blossom Video Game Messaging App – Part2 and Part3  tutorial is used for developing attractive user interfaces
class LabelValueWidget extends StatelessWidget {
  final String label, value;
  final TextStyle labelStyle, valueStyle;

  LabelValueWidget({Key? key, required this.label, required this.value, required this.labelStyle, required this.valueStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(value, style: valueStyle),
        Text(label, style: labelStyle),
      ],
    );
  }
}