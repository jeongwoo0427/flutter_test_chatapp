import 'package:flutter/material.dart';

import '../model/message_model.dart';

class MessageItemWidget extends StatelessWidget {
  bool isMine;
  MessageModel messageModel;

  MessageItemWidget({required this.isMine,required this.messageModel});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;


    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: this.isMine?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: this.isMine?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 3),
                child: Text(messageModel.nickname.trim()==''?'unkown':messageModel.nickname,style: TextStyle(color: messageModel.nickname.trim()==''?Colors.black38:Colors.black87),)),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(0),
                  primary: isMine?Color(0xFFFCFFA9):Colors.white),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.transparent),
                constraints: BoxConstraints(maxWidth: screenSize.width / 1.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.messageModel.content,
                      style: TextStyle(fontSize: 15, color: Colors.black87,fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        this
                            .messageModel
                            .sendDate
                            .toDate()
                            .toLocal()
                            .toString()
                            .substring(5, 16),
                        style: TextStyle(fontSize: 13, color: Colors.black26))
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
