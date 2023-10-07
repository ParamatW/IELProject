// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.hint,
    this.suffixWidget,
    this.obscure,
  }) : super(key: key);

  final String? hint;
  final Widget? suffixWidget;
  final bool? obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure ?? false,
      decoration: InputDecoration(
        filled: true,
        border: InputBorder.none,
        hintText: hint,
        suffixIcon: suffixWidget,
      ),
    );
  }
}