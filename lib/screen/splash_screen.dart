import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/screen/chatroom_list_screen.dart';

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
    Future.delayed(Duration(milliseconds: 500), () async {
      Navigator.of(context, rootNavigator: true)
          .pushReplacementNamed(ChatroomListScreen.ROUTE_NAME);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text('IZ Talk',style: TextStyle(fontSize: 45,fontWeight: FontWeight.w700,color: Theme.of(context).primaryColor),)),
    );
  }
}
