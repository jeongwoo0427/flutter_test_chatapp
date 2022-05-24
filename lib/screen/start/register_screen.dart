import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/mixin/dialog_mixin.dart';
import 'package:flutter_test_chatapp/mixin/validator_mixin.dart';
import 'package:flutter_test_chatapp/state/user_state.dart';
import 'package:flutter_test_chatapp/widget/front_container_widget.dart';
import 'package:flutter_test_chatapp/widget/input/rounded_input_widget.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidatorMinxin ,DialogMixin{

  String email = '';
  String password = '';
  String password2 = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: FrontContainerWidget(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 530,
        width: 330,
        child: Form(
          key: validationKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Register',
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
                height: 10,
              ),
              RoundedInputWidget(
                labelText: '패스워드',
                onChanged: (value){password = value;},
                validator: passwordValidation,
              ),
              RoundedInputWidget(
                labelText: '패스워드 확인',
                onChanged: (value){password2 = value;},
                validator: (value){
                  if(value.toString().trim() ==''){
                    return '확인 패스워드를 입력해주세요.';
                  }

                  if(value.toString() != password){
                    return '확인 비밀번호가 다릅니다.';
                  }

                },
              ),
              SizedBox(
                height: 50,
              ),
              FrontContainerWidget(
                  onTap: _onTapRegisterButton,
                  width: 100,
                  height: 40,
                  child: Center(
                    child: Text('회원가입'),
                  )),
              SizedBox(height: 10,),
              MaterialButton(onPressed: _onTapLogin,child: Text('로그인으로'),)
            ],
          ),
        ),
      ),
    ));
  }

  void _onTapRegisterButton() async{
    if (!checkValidate()) return;

    final result = await Provider.of<UserState>(context,listen: false).registerWithEmail(email,password);


    if(result == 'success'){
      showAlertDialog(context, title: '로그인 성공', content:'정상적으로 로그인 되었습니다.');
      Navigator.pop(context,true);
    }else{
      showAlertDialog(context, title: '로그인 오류', content: result.toString());
    }
  }

  void _onTapLogin()async{
    Navigator.pop(context);
  }


}
