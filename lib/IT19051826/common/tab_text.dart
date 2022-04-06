import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styleguide/text_styles.dart';

//Techie Blossom Video Game Messaging App – Part2 and Part3  tutorial is used for developing attractive user interfaces
class TabText extends StatelessWidget {
  final bool isSelected;
  final String? text;
  final VoidCallback onTabTap;

  TabText({required this.isSelected, this.text,  required this.onTabTap});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -1.58,
      child: InkWell(
        onTap: onTabTap,
        child: AnimatedDefaultTextStyle(
          style: isSelected ? selectedTabStyle : defaultTabStyle,
          duration: const Duration(milliseconds: 500),
          child: Text(
          text!,

        ),
        ),
      ),
    );
  }
}
