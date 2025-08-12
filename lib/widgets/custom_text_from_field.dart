import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;

  final TextInputType? keyboardType;
  final bool obscureText;
  final int maxLines;
  final Widget? perfixIcon;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  CustomTextFormField({
    super.key,

    required this.labelText,

    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.perfixIcon,
    this.onChanged,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: TextFormField(
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: perfixIcon,
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3.0,
            ),
          ),
        ),
        onChanged: onChanged,
        onSaved: onSaved,
      ),
    );
  }
}
