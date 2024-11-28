import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/colors.dart';
import '../../helpers/methods.dart';

class MyCheckBox extends StatelessWidget {
  const MyCheckBox({
    super.key,
    required this.label,
    required this.value,
    this.isDark,
    required this.onChanged,
    this.addInfo,
    this.infoText,
  });

  final String label;
  final String? infoText;
  final bool? value;
  final bool? isDark;
  final bool? addInfo;
  final Function() onChanged;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              onChanged();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Theme(
                    data: ThemeData(unselectedWidgetColor: redDarkColor),
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      value: value,
                      activeColor: (isDark != null)
                          ? isDark!
                              ? whiteColor
                              : blackColor
                          : redDarkColor,
                      checkColor: (isDark != null)
                          ? isDark!
                              ? greyColor
                              : whiteColor
                          : whiteColor,
                      onChanged: (val) {
                        onChanged();
                      },
                    ),
                  ),
                  Text(
                    label,
                    style: textStyle(
                      color: (isDark != null)
                          ? isDark!
                              ? whiteColor
                              : greyColor
                          : blackColor,
                      fontWeight: FontWeight.w600,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (addInfo ?? false)
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              preferBelow: false,
              message: infoText ?? '',
              decoration: BoxDecoration(
                color: redDarkColor,
                borderRadius: BorderRadius.circular(14),
              ),
              textStyle: textStyle(
                color: whiteColor,
                fontWeight: FontWeight.w500,
                size: 12,
              ),
              showDuration: const Duration(seconds: 2),
              child: const Icon(
                FontAwesomeIcons.circleInfo,
                color: redDarkColor,
                size: 17,
              ),
            ),
        ],
      ),
    );
  }
}
