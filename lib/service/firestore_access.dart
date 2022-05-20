import '../model/message_model.dart';
import 'firestore_service.dart';

class FirestoreAccess {
  final _firestoreService = FirestoreService.instance;

  Stream<List<MessageModel>> streamMessage(String chatId) =>
      _firestoreService.collectionStream(
          collectionPath: 'chatrooms/$chatId/messages',
          builder: (docId, data) => MessageModel.fromMap(id: docId, map: data),
          order: 'sendDate');

  Future<void> addMessage(
          {required String chatId, required MessageModel messageModel}) =>
      _firestoreService.add(
          collectionPath: 'chatrooms/$chatId/messages',
          data: messageModel.toMap());
}
