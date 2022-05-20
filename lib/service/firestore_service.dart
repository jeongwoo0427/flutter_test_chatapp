
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  FirestoreService._();
  static final instance = FirestoreService._();


  Future<void> add({required String collectionPath, required Map<String,dynamic> data})async{
    final reference = FirebaseFirestore.instance.collection(collectionPath);
    log('FirestoreService_add : $collectionPath : $data');
    await reference.add(data);
  }

  Future<void> delete({required String collectionPath, required String docId}) async{
    final reference = FirebaseFirestore.instance.collection(collectionPath).doc(docId);
    log('FirestoreService_delete : $collectionPath : $docId');
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({required String collectionPath, required T builder(String docId, Map<String,dynamic> data), String order = '',bool descending = false}) {
    //찾고자 하는 컬렉션의 스냅샷(Stream)을 가져온다.
    final Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance.collection(collectionPath).orderBy(order,descending: descending).snapshots();

    //새낭 스냅샷(Stream)내부의 자료들을 List<MessageModel> 로 변환하기 위해 map을 사용하도록 한다.
    return snapshots.map((querySnapshot){
      return querySnapshot.docs.map((doc) => builder(doc.id,doc.data() as Map<String,dynamic>)).toList();
    }); //Stream<QuerySnapshot> 에서 Stream<List<MessageModel>>로 변경되어 반환됨
  }

  Stream<T> documentStream<T>({required String collectionPath, required builder(String docId, Map<String,dynamic> data)}) {
    final Stream<DocumentSnapshot> snapshots = FirebaseFirestore.instance.doc(collectionPath).snapshots();
    return snapshots.map((snapshot) =>
        builder( snapshot.id,snapshot.data() as Map<String, dynamic>));
  }

}