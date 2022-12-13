import 'package:flutter/material.dart';

class TextFormFiledComponent extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final Function(String)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  const TextFormFiledComponent({
    super.key,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      cursorColor: Theme.of(context).primaryColor,
      style: Theme.of(context).textTheme.headline4,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText ?? '',
        hintStyle:
            TextStyle(color: Colors.grey[400], fontSize: 16.0, height: 1.0),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: 20.0,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      validator: validator as String? Function(String?)?,
    );
  }
}
