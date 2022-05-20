import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/widget/front_container_widget.dart';

class CreateChatroomScreen extends StatefulWidget {
  const CreateChatroomScreen({Key? key}) : super(key: key);

  @override
  State<CreateChatroomScreen> createState() => _CreateChatroomScreenState();
}

class _CreateChatroomScreenState extends State<CreateChatroomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('채팅방 생성'),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: Center(
          child: FrontContainerWidget(
            height: 300,width: 300,
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(children: [
                  Text('채팅방 이름')
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
