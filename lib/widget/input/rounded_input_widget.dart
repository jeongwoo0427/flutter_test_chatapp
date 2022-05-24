import 'package:flutter/material.dart';

class RoundedInputWidget extends StatelessWidget {

  String? labelText;
  FormFieldValidator<String>? validator;
  ValueChanged<String>? onChanged;

  RoundedInputWidget({this.labelText,this.onChanged,this.validator});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText
    ),
    );
  }
}
