// DEFAULTS

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/theme_switch_bloc/theme_switch_bloc.dart';
import 'colors.dart';
// import 'package:muhasba/blocs/bloc_exports.dart';
// import 'package:muhasba/constants/colors.dart';

const int maxValue = 9999999;

TextStyle defaultTextFieldStyle(
  BuildContext context, {
  FontWeight? fontWeight,
  Color? color,
}) {
  bool isDark = context.read<ThemeSwitchBloc>().state.isDarkTheme;
  return GoogleFonts.poppins(
    fontWeight: fontWeight ?? FontWeight.w600,
    color: color ?? (isDark ? blackColor : whiteColor),
    fontSize: 14,
    height: 1.6,
  );
}
