import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import '../../constants/default_constants.dart';
import '../../Constants/default_constants.dart';
import '../../helpers/methods.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    this.controller,
    this.prefixIcon,
    required this.hintText,
    this.errorText,
    this.maxLines,
    this.maxLength,
    this.readOnly,
    this.textAlign,
    this.onChanged,
    this.textInputType,
    this.fontWeight,
    required this.validator,
    this.inputFormatters,
    this.focusNode,
    this.onTap,
    this.borderRadius,
    this.obscureText,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final bool? obscureText;
  final FocusNode? focusNode;
  final String? errorText;
  final int? maxLines;
  final int? maxLength;
  final BorderRadius? borderRadius;
  final Function(String)? onChanged;
  final FontWeight? fontWeight;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      onTap: onTap,
      scrollPadding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      obscuringCharacter: "◆",
      readOnly: readOnly ?? false,
      keyboardType: textInputType,
      textAlign: textAlign ?? TextAlign.start,
      cursorWidth: 2,
      decoration: inputDecoration(
        context,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        borderRadius: borderRadius,
      ),
      style: defaultTextFieldStyle(context, fontWeight: fontWeight),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return errorText ?? "Enter ${hintText.toLowerCase()} please";
            }
            return null;
          },
      onChanged: onChanged,
      inputFormatters: inputFormatters,
    );
  }
}
