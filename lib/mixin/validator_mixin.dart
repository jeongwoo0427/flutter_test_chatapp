
import 'package:flutter/material.dart';

mixin ValidatorMinxin {
  final validationKey = GlobalKey<FormState>();

  bool checkValidate(){
    return validationKey.currentState!.validate();
  }

  String? emailValidation(final value){
    if(value.toString().trim() ==''){
      return '이메일을 입력하세요.';
    }

    return null;
  }

  String? passwordValidation(final value){
    if(value.toString().trim() == ''){
      return '패스워드를 입력하세요.';
    }

    return null;
  }
}