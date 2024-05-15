import 'package:flutter/material.dart';

import '../themes/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {super.key,
      this.hintText,
      this.lableText,
      this.onChanged,
      this.obscureText = false,
      this.icon,
      this.suffixIcon});
  String? hintText;
  String? lableText;
  Function(String)? onChanged;
  bool? obscureText;
  Icon? icon;
  IconButton? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field is required';
        }
      },
      onChanged: onChanged,
      cursorColor: textColor,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        prefixIcon: icon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelStyle: TextStyle(
          color: textColor,
        ),
        labelText: lableText,
        hintStyle: TextStyle(
          color: textColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: textColor,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
