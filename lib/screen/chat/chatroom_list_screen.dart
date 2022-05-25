import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/mixin/dialog_mixin.dart';
import 'package:flutter_test_chatapp/model/chatroom_model.dart';
import 'package:flutter_test_chatapp/screen/chat/message_list_screen.dart';
import 'package:flutter_test_chatapp/state/user_state.dart';
import 'package:flutter_test_chatapp/widget/front_container_widget.dart';
import 'package:provider/provider.dart';

import '../../cache/preference_helper.dart';
import '../../routes.dart';
import '../../service/firestore_data.dart';

class ChatroomListScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/chatroom_list_screen';

  const ChatroomListScreen({Key? key}) : super(key: key);

  @override
  State<ChatroomListScreen> createState() => _ChatroomListScreenState();
}

class _ChatroomListScreenState extends State<ChatroomListScreen>
    with DialogMixin {
  TextEditingController nicknameController = TextEditingController(text: '');

  @override
  initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onPressedNewRoom,
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        title: Text('IZ Talk'),
        actions: [
          MaterialButton(
            onPressed: _onPressedProfile,
            child: Text(
              '프로필',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: StreamBuilder<List<ChatroomModel>>(
        stream: FirestoreData().streamChatrooms(), //중계하고 싶은 Stream을 넣는다.
        builder: (context, asyncSnapshot) {
          //return Container();
          if (!asyncSnapshot.hasData) {
            //데이터가 없을 경우 로딩위젯을 표시한다.
            return const Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return const Center(
              child: Text('오류가 발생했습니다.'),
            );
          } else {
            List<ChatroomModel> chatrooms =
                asyncSnapshot.data!; //비동기 데이터가 존재할 경우 리스트뷰 표시

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: _getChatroomItems(chatrooms),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  List<Widget> _getChatroomItems(List<ChatroomModel> chatrooms) {
    List<Widget> widgets = [];
    chatrooms.forEach((element) {
      widgets.add(FrontContainerWidget(
          onTap: (){_onPressedRoomItem(element);},
          child: Padding(
            padding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [element.password!=''?Icon(Icons.lock,size: 16,):Container(), Text(element.name)],
              ),
              SizedBox(height: 10,),
              Text(element.recentMessage,style: TextStyle(color: Colors.grey),)
            ],)
          )));
    });
    return widgets;
  }



  void _onPressedProfile() async{
    // final UserState userState = Provider.of<UserState>(context,listen: false);
    // final result = await showTextDialog(context, title: '표시할 닉네임을 입력하세요', hintText: 'ex)근육쟁이',initialText:userState.getUser().displayName??'');
    // if(result !=null){
    //   userState.updateNickname(result.toString());
    // }
    Navigator.pushNamed(context, Routes.profile);
  }

  void _onPressedRoomItem(ChatroomModel roomModel) async{

    if(roomModel.password.trim() != ''){
      final result = await showTextDialog(context, title: '패스워드', hintText: '');
      if(result.toString() == roomModel.password){
        Navigator.pushNamed(context, Routes.messageList,
            arguments: roomModel);
      }else if(result != null){
        showAlertDialog(context, title: '패스워드 오류', content: '패스워드가 다릅니다.');
      }
    }else{
      Navigator.pushNamed(context, Routes.messageList,
          arguments: roomModel);
    }
  }

  void _onPressedNewRoom() async {
    TextEditingController roomNameController = TextEditingController(text: '');
    TextEditingController passwordController = TextEditingController(text: '');
    bool isUsePassword = false;
    final result = await showCardDialog(context,
        titleChild: Center(
          child: Text('채팅방 생성'),
        ),
        height: 300,
        contentChild: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: StatefulBuilder(
            builder: (context,setDialogState){
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  TextField(
                    controller: roomNameController,
                    decoration: InputDecoration(hintText: '채팅방 이름'),
                  ),
                  Row(children: [
                    Text('암호'),
                    Checkbox(value: isUsePassword, onChanged: (value){setDialogState((){ isUsePassword = value??false;});}),
                    Expanded(
                      child: TextField(
                        enabled: isUsePassword,
                        controller: passwordController,
                      ),
                    )
                  ],),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [MaterialButton(onPressed: () {
                      if(roomNameController.text.trim()==''){
                        showAlertDialog(context, title: '경고', content: '채팅방 이름을 입력하세요.');
                        return;
                      }

                      if(isUsePassword&&passwordController.text.trim()==''){
                        showAlertDialog(context, title: '경고', content: '패스워드를 입력하세요.');
                        return;
                      }

                      Navigator.pop(context,true);},child: Text('완료'),)],
                  )
                ],
              );
            },
          ),
        ));
    if(result == true){
      ChatroomModel chatroomModel = ChatroomModel(
        name: roomNameController.text,
        password: isUsePassword?passwordController.text:'',
      );
      FirestoreData().addChatroom(chatroomModel: chatroomModel);
    }
  }


}
