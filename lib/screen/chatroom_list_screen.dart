import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/mixin/dialog_mixin.dart';
import 'package:flutter_test_chatapp/model/chatroom_model.dart';

import '../cache/preference_helper.dart';
import '../service/firestore_access.dart';

class ChatroomListScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/chatroom_list_screen';
  const ChatroomListScreen({Key? key}) : super(key: key);

  @override
  State<ChatroomListScreen> createState() => _ChatroomListScreenState();
}

class _ChatroomListScreenState extends State<ChatroomListScreen> with DialogMixin{
  TextEditingController nicknameController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEFFF),
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        title: Text('IZ Talk'),
        actions: [
          MaterialButton(
            onPressed: () {
              _showNicknameDlg();
            },
            child: Text(
              '닉네임 변경',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: StreamBuilder<List<ChatroomModel>>(
        stream: FirestoreAccess().streamChatrooms(), //중계하고 싶은 Stream을 넣는다.
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
            List<ChatroomModel> chatrooms = asyncSnapshot.data!; //비동기 데이터가 존재할 경우 리스트뷰 표시
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                        itemCount: chatrooms.length,
                        separatorBuilder: (context,_){
                          return SizedBox(height: 15,);
                        },
                        itemBuilder: (context, index) {
                          return ListTile(title: Text(chatrooms[index].name),);
                        })),
              ],
            );
          }
        },
      ),
    );
  }


  void _showNicknameDlg() {
    showDialog(
        context: context,
        builder: (context) {
          Size screenSize = MediaQuery.of(context).size;
          return Dialog(
            child: Container(
              height: 200,
              width: 100,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('표시할 닉네임을 입력하세요.',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                    TextField(controller: nicknameController,decoration: InputDecoration(hintText: 'ex)근육쟁이'),),
                    Row(children: [
                      Expanded(child: Container(),),
                      MaterialButton(onPressed:_onPressedEditNickname,child: Text('완료'),)
                    ],)
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _onPressedEditNickname(){
    if(nicknameController.text.trim() == ''){
      showAlertDialog(context,title: '주의', content: '닉네임을 입력해주세요');
      return;
    }
    PrefernceHelper().setNickname(nicknameController.text);
    Navigator.pop(context);

  }
}
