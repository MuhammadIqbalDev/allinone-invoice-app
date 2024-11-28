import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../helpers/methods.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: textStyle(
              fontWeight: FontWeight.bold,
              size: 24,
              color: redDarkColor,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            subtitle,
            style: textStyle(
              fontWeight: FontWeight.w600,
              size: 15,
              color: blackColor,
            ),
          ),
        ),
      ],
    );
  }
}
