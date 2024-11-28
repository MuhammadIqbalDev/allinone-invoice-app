import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../helpers/methods.dart';

void showErrorDialog(
  BuildContext context,
  String? label,
  String text, {
  Color mainColor = redDarkColor,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label ?? "Something went wrong!",
              style: textStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                size: 18,
              ),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: textStyle(
                color: blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
              ),
              child: Text(
                "OK",
                style: textStyle(
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                ),
              ),
            ),
          ]
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: e,
                ),
              )
              .toList(),
        ),
      );
    },
  );
}
