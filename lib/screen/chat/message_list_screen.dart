import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/model/message_model.dart';
import 'package:flutter_test_chatapp/service/firestore_data.dart';
import 'package:flutter_test_chatapp/state/user_state.dart';
import 'package:flutter_test_chatapp/widget/message_item_widget.dart';
import 'package:provider/provider.dart';

import '../../cache/preference_helper.dart';
import '../../mixin/dialog_mixin.dart';
import '../../model/chatroom_model.dart';

class MessageListScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/message_list_screen';
  final ChatroomModel chatroomModel;

  MessageListScreen({required this.chatroomModel});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> with DialogMixin{
  FocusNode messageFocus = FocusNode();
  TextEditingController messageController = TextEditingController(text: '');
  ScrollController scrollController = ScrollController();

  @override
  initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context,listen: true);
    return Scaffold(
      backgroundColor: Color(0xFFEAEFFF),
      appBar: AppBar(
        title: Text(widget.chatroomModel.name),
      ),
      body: StreamBuilder<List<MessageModel>>(
        stream: FirestoreData().streamMessages(widget.chatroomModel.id), //중계하고 싶은 Stream을 넣는다.
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            //데이터가 없을 경우 로딩위젯을 표시한다.
            return const Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return const Center(
              child: Text('오류가 발생했습니다.'),
            );
          } else {
            List<MessageModel> messages = asyncSnapshot.data!; //비동기 데이터가 존재할 경우 리스트뷰 표시
            return Column( 
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        messageFocus.unfocus();
                      },
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                        reverse: true, //새로운 글은 맨 밑에서부터 시작되므로 역스크롤을 추가함
                          controller: scrollController,
                          itemCount: messages.length,
                          separatorBuilder: (context,_){
                            return SizedBox(height: 15,);
                          },
                          itemBuilder: (context, index) {
                            bool isMine = false;

                            return MessageItemWidget(isMine: isMine,messageModel:messages[index]);
                          }),
                    )),
                getInputWidget()
              ],
            );
          }
        },
      ),
    );
  }

  Widget getInputWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: Colors.black12, offset: Offset(0, -2), blurRadius: 3)
      ], color: Theme.of(context).bottomAppBarColor),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextField(
                onSubmitted: (value){
                  _onPressedSendButton();
                 },
                focusNode: messageFocus,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 8,
                controller: messageController,
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  labelStyle: TextStyle(fontSize: 15),
                  hintText: '내용을 입력하세요..',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.black26,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            RawMaterialButton(
              onPressed: _onPressedSendButton, //전송버튼을 누를때 동작시킬 메소드
              constraints: BoxConstraints(
                minWidth: 0,
                minHeight: 0
              ),
              elevation: 2,
              fillColor: Theme.of(context).colorScheme.primary,
              shape: CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.send,color: Colors.white,),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onPressedSendButton() async{
    try {
      final UserState userState = Provider.of<UserState>(context,listen: false);
      //내용이 존재하지 않을 경우 경고메시지 표시
      if (messageController.text.trim() == '') {
        showAlertDialog(context,title: '주의',content: '내용을 입력해주세요.');
        return;

      }
      final message = messageController.text;
      messageController.text = '';

      //서버로 보낼 데이터를 모델클래스에 담아둔다.
      //여기서 sendDate에 Timestamp.now()가 들어가는데 이는 디바이스의 시간을 나타내므로 나중에는 서버의 시간을 넣는 방법으로 변경하도록 하자.
      MessageModel messageModel = MessageModel(content: message,nickname: userState.getUser()!.displayName??'unkown',sendDate: Timestamp.now());
      widget.chatroomModel.recentMessage = message;
      FirestoreData().addMessage(chatId: widget.chatroomModel.id, messageModel: messageModel);
      FirestoreData().updateChatroom(chatroomModel: widget.chatroomModel);

    }catch(ex){
      log('error)',error: ex.toString(),stackTrace: StackTrace.current);
    }
  }


}
