import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/model/message_model.dart';
import 'package:firebase_core/firebase_core.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('메세지 목록')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/oxvpcBxvy18GNGwdxPYs/messages')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('오류가 발생했습니다.'),
            );
          } else {
            final docs = snapshot.data!.docs;

            return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context,index){
              return ListTile(title: Text(docs[index]['content']),);
            });
          }
        },
      ),
    );
  }
}
