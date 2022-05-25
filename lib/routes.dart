
import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/screen/chat/chatroom_list_screen.dart';
import 'package:flutter_test_chatapp/screen/chat/create_chatroom_screen.dart';
import 'package:flutter_test_chatapp/screen/chat/message_list_screen.dart';
import 'package:flutter_test_chatapp/screen/profile/profile_screen.dart';
import 'package:flutter_test_chatapp/screen/splash_screen.dart';
import 'package:flutter_test_chatapp/screen/start/login_screen.dart';
import 'package:flutter_test_chatapp/screen/start/register_screen.dart';
import 'package:flutter_test_chatapp/screen/unkown_screen.dart';

import 'model/chatroom_model.dart';

class Routes{

  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String chatroomList = '/chatroomList';
  static const String createChatroom = '/createChatroom';
  static const String messageList = '/messageList';

  MaterialPageRoute getRoutes(BuildContext context,{required RouteSettings settings}){
    return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          if (settings.name == splash|| settings.name == '/') {
            return SplashScreen();
          }else if (settings.name == login) {
            return LoginScreen();
          }else if (settings.name == register) {
            return RegisterScreen();
          }else if (settings.name == profile) {
            return ProfileScreen();
          }else if (settings.name == chatroomList) {
            return ChatroomListScreen();
          }else if(settings.name == createChatroom){
            return CreateChatroomScreen();
          }else if(settings.name == messageList){
            return MessageListScreen(chatroomModel: settings.arguments as ChatroomModel);
          }

          else{
            return UnknownScreen();
          }
        });
  }
}

