import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/colors.dart';
import '../../constants/default_constants.dart';

import '../../helpers/methods.dart';

class TextFieldWithLabel extends StatefulWidget {
  const TextFieldWithLabel({
    super.key,
    required this.label,
    required this.hint,
    this.onTap,
    required this.textInputType,
    required this.textEditingController,
    required this.isPasswordField,
    this.focusNode,
    this.readOnly,
    this.suffixErrorIcon,
    this.suffixIcon,
    this.optionalValidations,
    this.inputFormatters,
    this.labelWidth,
    this.onChanged,
    this.maxLength,
  });

  final String label;
  final String hint;
  final double? labelWidth;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPasswordField;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final int? maxLength;
  final Widget? suffixErrorIcon;
  final bool? readOnly;
  final Function()? onTap;
  final Function(String value)? onChanged;
  final String? Function(String value)? optionalValidations;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<TextFieldWithLabel> createState() => _TextFieldWithLabelState();
}

class _TextFieldWithLabelState extends State<TextFieldWithLabel> {
  bool onError = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: widget.labelWidth ?? MediaQuery.of(context).size.width * 0.30,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 12,
          ),
          decoration: const BoxDecoration(
            color: greyLightColor,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
            ),
          ),
          child: Text(
            widget.label,
            style: textStyle(
              fontWeight: FontWeight.w500,
              color: blackColor,
              size: 14,
            ),
          ),
        ),
        Flexible(
          child: Theme(
            data: ThemeData(
              useMaterial3: true,
              colorScheme: const ColorScheme(
                brightness: Brightness.dark,
                primary: redDarkColor,
                onPrimary: redDarkColor,
                secondary: redDarkColor,
                onSecondary: redDarkColor,
                error: redDarkColor,
                onError: redDarkColor,
                background: redDarkColor,
                onBackground: redDarkColor,
                surface: redDarkColor,
                onSurface: redDarkColor,
              ),
            ),
            child: TextFormField(
              controller: widget.textEditingController,
              obscureText: widget.isPasswordField,
              obscuringCharacter: "◆",
              keyboardType: widget.textInputType,
              decoration: InputDecoration(
                hintText: widget.hint,
                counterText: "",
                contentPadding: const EdgeInsets.fromLTRB(8, 12, 0, 12),
                hintStyle: textStyle(
                  fontWeight: FontWeight.w600,
                  color: blackColor.withAlpha(120),
                  size: 14,
                ),
                suffixIcon: onError
                    ? widget.suffixErrorIcon ??
                        const Icon(
                          Icons.error,
                          color: redDarkColor,
                        )
                    : widget.suffixIcon,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorStyle: const TextStyle(fontSize: 0, height: -1),
              ),
              onChanged: widget.onChanged,
              cursorColor: redDarkColor,
              readOnly: widget.readOnly ?? false,
              maxLength: widget.maxLength,
              cursorWidth: 2,
              style: defaultTextFieldStyle(
                context,
                fontWeight: FontWeight.bold,
                color: blackColor,
              ),
              focusNode: widget.focusNode,
              onTap: widget.onTap,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    onError = true;
                  });
                  return "Enter ${widget.label.toLowerCase()} please";
                } else if (widget.optionalValidations != null) {
                  if (widget.optionalValidations!(value) == 'len') {
                    setState(() {
                      onError = true;
                    });
                  } else if (widget.optionalValidations!(value) ==
                      'Invalid Email') {
                    setState(() {
                      onError = true;
                    });
                  }
                  return widget.optionalValidations!(value);
                }
                setState(() {
                  onError = false;
                });
                return null;
              },
              inputFormatters: widget.inputFormatters,
            ),
          ),
        ),
      ],
    );
  }
}
