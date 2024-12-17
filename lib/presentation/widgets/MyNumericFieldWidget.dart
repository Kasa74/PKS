import 'package:flutter/material.dart';

class MyNumericFieldWidget extends StatefulWidget {
  const MyNumericFieldWidget({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.initialValue
  });

  final ValueChanged<String>? onChanged;
  final String hintText;
  final int? initialValue;

  @override
  State<MyNumericFieldWidget> createState() => _MyNumericFieldWidgetState(
      onChanged: onChanged,
      hintText: hintText,
      initialValue: initialValue
  );
}

class _MyNumericFieldWidgetState extends State<MyNumericFieldWidget> {
  final ValueChanged<String>? onChanged;
  final String hintText;
  final int? initialValue;

  _MyNumericFieldWidgetState({
    required this.onChanged,
    required this.hintText,
    this.initialValue
  });

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
        initialValue: initialValue.toString(),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: hintText
        ),
      );
  }
}
