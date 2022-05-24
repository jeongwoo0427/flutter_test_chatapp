import 'package:flutter/material.dart';

class RoundedInputWidget extends StatelessWidget {

  String? labelText;
  FormFieldValidator<String>? validator;

  RoundedInputWidget({this.labelText,this.validator});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText
    ),
    );
  }
}
