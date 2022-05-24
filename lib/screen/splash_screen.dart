import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/cache/preference_helper.dart';
import 'package:flutter_test_chatapp/state/user_state.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import 'chat/chatroom_list_screen.dart';

class SplashScreen extends StatefulWidget {
  static const ROUTE_NAME = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startLogin();
  }

  void startLogin() {
    Future.delayed(Duration(milliseconds: 1500), () async {

      UserState userState = Provider.of<UserState>(context,listen: false);

      await userState.prepareUser();
      User user = userState.getUser()!;
      log('isAnony=${user.isAnonymous.toString()} email=${user.email} uid=${user.uid} displayName=${user.displayName}');

      Navigator.of(context, rootNavigator: true)
          .pushReplacementNamed(Routes.chatroomList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child:  Row(
            mainAxisSize: MainAxisSize.min,
            children: [
            Image.asset('assets/images/izcharacter.jpg',fit: BoxFit.fitWidth,width: 100,isAntiAlias: true,),
            SizedBox(width: 10,),
            Text(
              'IZ Talk',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor),
            )
          ],)),
    );
  }
}
