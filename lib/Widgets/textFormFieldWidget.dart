// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../Constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final Color cursorColor;
  final String? errorText;
  final Color? CursorStyle;
  final keyboardType;
  final onSaved;
  final validator;
  final suffixText;
  final onTap;
  final enabled;
  final focusnode;
  final enableInteractiveSelection;
  final initialvalue;
  
  // final bool editable;

  const CustomTextFormField({
    Key? key,
    // this.editable = false,
    required this.controller,
    this.focusnode,
    this.labelText,
    this.enabled,
    this.cursorColor = Colors.grey,
    this.errorText,
    this.CursorStyle,
    this.keyboardType,
    this.onSaved,
    this.validator,
    this.suffixText,
    this.onTap,
    this.enableInteractiveSelection, this.initialvalue,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
          enableInteractiveSelection: enableInteractiveSelection,
          focusNode: focusnode,
          initialValue: initialvalue,
          enabled: enabled,
          validator: validator,
          onSaved: onSaved,
          keyboardType: keyboardType,
          cursorColor: cursorColor,
          controller: controller,
          onTap: onTap,
          // enabled: editable,
          decoration: InputDecoration(
              floatingLabelStyle: TextStyle(color: primary),
              // suffixStyle: c,
              suffixStyle: const TextStyle(color: blackColor),
              labelText: labelText,
              suffixText: suffixText,
              labelStyle: TextStyle(color: black.withOpacity(0.5)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: grey.withOpacity(0.2))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: grey.withOpacity(0.2))),
              // errorStyle: const TextStyle(color: Colors.red),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: grey.withOpacity(0.2))))),
    );
  }
}
