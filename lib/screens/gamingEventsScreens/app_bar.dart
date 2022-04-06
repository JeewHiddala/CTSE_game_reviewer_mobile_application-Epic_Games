import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String sectionName;
  const AppBarTitle({
    Key?key,
    required this.sectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 8),
        const Text(
          'Game Reviewer',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        Text(
          ' $sectionName ',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}