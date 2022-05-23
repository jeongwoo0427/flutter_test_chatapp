import 'package:flutter_test_chatapp/model/chatroom_model.dart';

import '../model/message_model.dart';
import 'firestore_service.dart';

class FirestoreAccess {
  final _firestoreService = FirestoreService.instance;

  Stream<List<MessageModel>> streamMessages(String chatId) =>
      _firestoreService.streamCollection(
          collectionPath: 'chatrooms/$chatId/messages',
          builder: (docId, data) => MessageModel.fromMap(id: docId, map: data),
          order: 'sendDate',
          descending: true
      );

  Future<void> addMessage(
          {required String chatId, required MessageModel messageModel}) =>
      _firestoreService.add(
          collectionPath: 'chatrooms/$chatId/messages',
          data: messageModel.toMap());



  Stream<List<ChatroomModel>> streamChatrooms() =>
      _firestoreService.streamCollection(
          collectionPath: 'chatrooms',
          builder: (docId, data) => ChatroomModel.fromMap(id: docId, map: data),
          descending: true
      );

  Future<void> addChatroom({required ChatroomModel chatroomModel}) =>
      _firestoreService.add(collectionPath: 'chatrooms', data: chatroomModel.toMap());

  Future<void> updateChatroom({required ChatroomModel chatroomModel}) =>
      _firestoreService.updae(collectionPath: 'chatrooms', docId:  chatroomModel.id,data: chatroomModel.toMap());


}
