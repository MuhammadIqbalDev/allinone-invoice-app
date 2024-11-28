// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/colors.dart';
import '../../Constants/name_variables.dart';
import '../../helpers/methods.dart';

class GenderSelectorWidget extends StatelessWidget {
  const GenderSelectorWidget({
    Key? key,
    required this.onTap,
    required this.isSelected,
    required this.genderName,
    required this.genderError,
    required this.imgString,
  }) : super(key: key);

  final void Function() onTap;
  final bool isSelected;
  final String genderName;
  final bool genderError;
  final String imgString;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        margin: (genderName == female)
            ? const EdgeInsets.only(left: 20)
            : EdgeInsets.zero,
        duration: const Duration(milliseconds: 300),
        height: 58,
        width: 135,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(
                  color: redDarkColor,
                  width: 2,
                )
              : null,
          color: isSelected ? whiteColor : greyLightColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? greyLightColor : whiteColor,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                imgString,
                filterQuality: FilterQuality.high,
              ),
            ),
            Text(
              genderError
                  ? "${nameFormater(genderName)}*"
                  : nameFormater(genderName),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: genderError
                    ? redDarkColor
                    : isSelected
                        ? redDarkColor
                        : blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
