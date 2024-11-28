import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../helpers/methods.dart';

class EndButtons extends StatelessWidget {
  const EndButtons({
    super.key,
    required this.mainBtnChild,
    required this.mainBtnPress,
    this.secondaryBtnChild,
    this.secondaryBtnPress,
    this.mainBtnPressed,
    this.mainBtnTapChild,
  });

  final Widget mainBtnChild;
  final Function() mainBtnPress;
  final Widget? secondaryBtnChild;
  final Function()? secondaryBtnPress;
  final bool? mainBtnPressed;
  final Widget? mainBtnTapChild;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: mainBtnPressed ?? false ? null : mainBtnPress,
          style: elevatedbuttonStyle(context, mainBtnPressed ?? false),
          child: mainBtnPressed ?? false ? mainBtnTapChild : mainBtnChild,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.008,
        ),
        TextButton(
          onPressed: secondaryBtnPress ??
              () {
                Navigator.of(context).pop();
              },
          child: secondaryBtnChild ??
              Text(
                "GO BACK",
                style: textStyle(
                  color: redDarkColor,
                  fontWeight: FontWeight.bold,
                  size: 16,
                ),
              ),
        ),
      ],
    );
  }
}
