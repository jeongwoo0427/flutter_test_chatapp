import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/widget/front_container_widget.dart';
import 'package:flutter_test_chatapp/widget/input/rounded_input_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: FrontContainerWidget(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        height: 400,
          width: 330,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LOGIN',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
              SizedBox(height: 50,),
              RoundedInputWidget(labelText: '이메일',),
              SizedBox(height: 30,),
              RoundedInputWidget(labelText: '패스워드',),
              SizedBox(height: 50,),
              FrontContainerWidget(
                onTap: (){},
                width: 100,height: 40,
                  child: Center(
                child: Text('Login'),
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
