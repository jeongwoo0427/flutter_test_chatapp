
import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/screen/chat/chatroom_list_screen.dart';
import 'package:flutter_test_chatapp/screen/chat/create_chatroom_screen.dart';
import 'package:flutter_test_chatapp/screen/chat/message_list_screen.dart';
import 'package:flutter_test_chatapp/screen/splash_screen.dart';
import 'package:flutter_test_chatapp/screen/unkown_screen.dart';

import 'model/chatroom_model.dart';

class Routes{

  static const String splash = '/splash';
  static const String chatroomList = '/chatroomList';
  static const String createChatroom = '/createChatroom';
  static const String messageList = '/messageList';

  MaterialPageRoute getRoutes(BuildContext context,{required RouteSettings settings}){
    return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          if (settings.name == splash|| settings.name == '/') {
            return SplashScreen();
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

