
import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/screen/chatroom_list_screen.dart';
import 'package:flutter_test_chatapp/screen/message_list_screen.dart';
import 'package:flutter_test_chatapp/screen/splash_screen.dart';
import 'package:flutter_test_chatapp/screen/unkown_screen.dart';

MaterialPageRoute getRoutes(BuildContext context,{required RouteSettings settings}){
  return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        if (settings.name == SplashScreen.ROUTE_NAME || settings.name == '/') {
          return SplashScreen();
        }else if (settings.name == ChatroomListScreen.ROUTE_NAME) {
          return ChatroomListScreen();
        }else if(settings.name == MessageListScreen.ROUTE_NAME){
          return MessageListScreen(chatDocId: settings.arguments as String);
        }

        else{
          return UnknownScreen();
        }
      });
}