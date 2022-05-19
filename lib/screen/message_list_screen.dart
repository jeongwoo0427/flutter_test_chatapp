import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/caches/preference_helper.dart';
import 'package:flutter_test_chatapp/model/message_model.dart';
import 'package:flutter_test_chatapp/widget/message_item_widget.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  TextEditingController messageController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  ScrollController scrollController = ScrollController();

  String nickname = '';

  @override
  initState(){
    super.initState();
    _fetchNickanme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEFFF),
      appBar: AppBar(
        title: Text('메세지 목록  (닉네임 : ${nickname == '' ? 'unknown' : nickname})'),
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
      body: StreamBuilder<List<MessageModel>>(
        stream: streamMessages(), //중계하고 싶은 Stream을 넣는다.
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
                          if(this.nickname!='' && this.nickname == messages[index].nickname){
                            isMine = true;
                          }
                          return MessageItemWidget(isMine: isMine,messageModel:messages[index]);
                        })),
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
      height: 60,
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
                controller: messageController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 15),
                  labelText: "내용을 입력하세요..",
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

  void _showAlertDialog({required String title, required String content}){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('네'),
              )
            ],
          );
        });
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

  void _fetchNickanme()async{
    await Future.delayed(Duration(milliseconds: 100));
    nickname = await PrefernceHelper().getNickname();
    nicknameController.text = nickname;
    if(nickname == ''){
      _showNicknameDlg();
    }
    setState((){});
  }

  void _onPressedEditNickname(){
    if(nicknameController.text.trim() == ''){
      _showAlertDialog(title: '주의', content: '닉네임을 입력해주세요');
      return;
    }
    PrefernceHelper().setNickname(nicknameController.text);
    _fetchNickanme();
    Navigator.pop(context);

  }

  void _onPressedSendButton(){
    try {
      //내용이 존재하지 않을 경우 경고메시지 표시
      if (messageController.text.trim() == '') {
        _showAlertDialog(title: '주의',content: '내용을 입력해주세요.');
        return;
      }

      //서버로 보낼 데이터를 모델클래스에 담아둔다.
      //여기서 sendDate에 Timestamp.now()가 들어가는데 이는 디바이스의 시간을 나타내므로 나중에는 서버의 시간을 넣는 방법으로 변경하도록 하자.
      MessageModel messageModel = MessageModel(content: messageController.text,nickname: this.nickname,sendDate: Timestamp.now());
      messageController.text = '';

      //Firestore 인스턴스 가져오기
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      //원하는 collection 주소에 새로운 document를 Map의 형태로 추가하는 모습.
      firestore.collection('chatrooms/YLCoRBj59XRsDdav2YV1/messages').add(messageModel.toMap());

    }catch(ex){
      log('error)',error: ex.toString(),stackTrace: StackTrace.current);
    }
  }

  Stream<List<MessageModel>> streamMessages(){
    try{
      //찾고자 하는 컬렉션의 스냅샷(Stream)을 가져온다.
      final Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance.collection('chatrooms/YLCoRBj59XRsDdav2YV1/messages').orderBy('sendDate',descending: true).snapshots();

      //새낭 스냅샷(Stream)내부의 자료들을 List<MessageModel> 로 변환하기 위해 map을 사용하도록 한다.
      //참고로 List.map()도 List 안의 element들을 원하는 형태로 변환하여 새로운 List로 반환한다
      return snapshots.map((querySnapshot){
        List<MessageModel> messages = [];//querySnapshot을 message로 옮기기 위해 List<MessageModel> 선언
        querySnapshot.docs.forEach((element) { //해당 컬렉션에 존재하는 모든 docs를 순회하며 messages 에 데이터를 추가한다.
          messages.add(
              MessageModel.fromMap(
                  id:element.id,
                  map:element.data() as Map<String, dynamic>
              )
          );
        });
        return messages; //QuerySnapshot에서 List<MessageModel> 로 변경이 됐으니 반환
      }); //Stream<QuerySnapshot> 에서 Stream<List<MessageModel>>로 변경되어 반환됨

    }catch(ex){//오류 발생 처리
      log('error)',error: ex.toString(),stackTrace: StackTrace.current);
      return Stream.error(ex.toString());
    }
  }
}
