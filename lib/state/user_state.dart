
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserState extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  Future<void> signInAnonymously() async{
    final UserCredential credential = await _auth.signInAnonymously();
    setUser(credential.user);
  }

  void setUser(User? user){
    _user = user;
    notifyListeners();
  }

  User? getUser() {
    return _user;
  }
}