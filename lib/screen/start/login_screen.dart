import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/mixin/dialog_mixin.dart';
import 'package:flutter_test_chatapp/mixin/validator_mixin.dart';
import 'package:flutter_test_chatapp/state/user_state.dart';
import 'package:flutter_test_chatapp/widget/appbar/default_appbar_widget.dart';
import 'package:flutter_test_chatapp/widget/front_container_widget.dart';
import 'package:flutter_test_chatapp/widget/input/rounded_input_widget.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidatorMinxin ,DialogMixin{

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getDefaultAppbar(titleText: '로그인'),
        body: Center(
      child: FrontContainerWidget(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 430,
        width: 330,
        child: Form(
          key: validationKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LOGIN',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 50,
              ),
              RoundedInputWidget(
                labelText: '이메일',
                onChanged: (value){email = value; },
                validator: emailValidation,
              ),
              SizedBox(
                height: 30,
              ),
              RoundedInputWidget(
                labelText: '패스워드',
                onChanged: (value){password = value;},
                validator: passwordValidation,
              ),
              SizedBox(
                height: 50,
              ),
              FrontContainerWidget(
                  onTap: _onTapLoginButton,
                  width: 100,
                  height: 40,
                  child: Center(
                    child: Text('로그인'),
                  )),
              SizedBox(height: 10,),
              MaterialButton(onPressed: _onTapRegisterButton,child: Text('회원가입'),)
            ],
          ),
        ),
      ),
    ));
  }

  void _onTapLoginButton() async{
    if (!checkValidate()) return;

    final result = await Provider.of<UserState>(context,listen: false).signInWithEmail(email,password);


    if(result == 'success'){
      showAlertDialog(context, title: '로그인 성공', content:'정상적으로 로그인 되었습니다.');
    }else{
      showAlertDialog(context, title: '로그인 오류', content: result.toString());
    }
  }
  void _onTapRegisterButton() async{
    final result = await Navigator.of(context).pushNamed(Routes.register);

    if(result == true){
      Navigator.pop(context);
    }
  }
}
