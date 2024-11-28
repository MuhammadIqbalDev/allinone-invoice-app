import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/bloc_exports.dart';
import '../../blocs/theme_switch_bloc/theme_switch_bloc.dart';
import '../../constants/colors.dart';
import '../../helpers/methods.dart';

Future<bool> showConfirmationDialog(
  BuildContext context,
  String label,
  String text,
  String doneLabel,
  String cancelLabel,
) async {
  bool isDark = context.read<ThemeSwitchBloc>().state.isDarkTheme;
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: isDark ? greyColor : whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: textStyle(
                  fontWeight: FontWeight.bold,
                  size: 18,
                  color: isDark ? whiteColor : blackColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22.0,
                vertical: 12,
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: textStyle(
                  fontWeight: FontWeight.w600,
                  size: 14,
                  color: isDark ? whiteColor : blackColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22.0,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? greyColor : whiteColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: isDark ? whiteColor : greyColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      cancelLabel,
                      style: textStyle(
                        fontWeight: FontWeight.w600,
                        size: 13,
                        color: isDark ? whiteColor : blackColor,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? whiteColor : blackColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      doneLabel,
                      style: textStyle(
                        fontWeight: FontWeight.w600,
                        size: 13,
                        color: isDark ? blackColor : whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  ).then((val) => val ?? false);
}
