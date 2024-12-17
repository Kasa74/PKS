import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatefulWidget {
  const MyTextFieldWidget({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.initialValue
  });

  final ValueChanged<String>? onChanged;
  final String hintText;
  final String? initialValue;

  @override
  State<MyTextFieldWidget> createState() => _MyTextFieldWidgetState(
    onChanged: onChanged,
    hintText: hintText,
    initialValue: initialValue
  );
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  final ValueChanged<String>? onChanged;
  final String hintText;
  final String? initialValue;

  _MyTextFieldWidgetState({
    required this.onChanged,
    required this.hintText,
    this.initialValue
  });

  @override
  Widget build(BuildContext context) {
    return
      TextFormField (
        onChanged: onChanged,
        initialValue: initialValue,
        decoration: InputDecoration(
            hintText: hintText
        ),
      );
  }
}
