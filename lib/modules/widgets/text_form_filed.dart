import 'package:flutter/material.dart';

import '../../core/style/app_color.dart';

class TextFormFiledComponent extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffix;
  bool obscureText = false;
  final FormFieldValidator<String>? validate;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  TextFormFiledComponent({
    super.key,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.prefixIcon,
    this.suffix,
    this.obscureText = false,
    this.onChanged,
    this.validate,
    this.onFieldSubmitted,
  });

  @override
  State<TextFormFiledComponent> createState() => _TextFormFiledComponentState();
}

class _TextFormFiledComponentState extends State<TextFormFiledComponent> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      cursorColor: Theme.of(context).primaryColor,
      style: Theme.of(context).textTheme.headlineMedium,
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hintText ?? '',
        hintStyle:
            TextStyle(color: Colors.grey[400], fontSize: 16.0, height: 1.0),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                size: 20.0,
              )
            : null,
        suffixIcon: widget.suffix != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                icon: Icon(
                  widget.obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColor.primerColor,
                  size: 20,
                ),
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
      validator: widget.validate,
    );
  }
}
