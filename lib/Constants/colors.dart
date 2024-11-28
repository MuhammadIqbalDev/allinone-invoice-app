import 'package:flutter/material.dart';

// COLORS

// Theme Colors

const Color whiteColor = Color(0xFFF3F3F3);
const Color secondaryWhiteColor = Color(0xFFe0e0e0);
const Color blackColor = Color(0xFF252525);
const Color greyLightColor = Color(0xFFe8e8e8);
const Color greyColor = Color(0xFF353238);
const Color redDarkColor = Color(0xFFb71c1c);

// Extra Colors
const Color blueColor = Color(0xFF0094FE);
const Color redColor = Color(0xFFFE0000);
const Color greenColor = Color(0xFF06C30D);
const Color newColor = Color(0xFFDF2B34);

  Color white = Colors.white;
  Color primaryDark = fromHex('#2b488e');
  Color primary = fromHex('#8E070E');
//  fromHex('#4f75b6');
  Color primaryLight = fromHex("#719bd1");
  Color primaryExtraLight = fromHex('#8da0cb');
  Color black = Colors.black;
  Color greyLight = const Color.fromARGB(255, 225, 225, 225);
  Color grey = Colors.grey;

  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }