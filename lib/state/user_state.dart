
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test_chatapp/cache/preference_helper.dart';

class UserState extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  Future<void> prepareUser() async{
    bool isFirst = await PreferenceHelper().getIsFirstStart();
    //최초 실행에 한에서 익명 로그인
    //모든 사용자는 앱을 켜자마자 익명 로그인이 진행된 상태가 되야한다.
    if(isFirst){
      print('UserState_prepareUser : signOut()');
      await _auth.signOut();
      await _auth.signInAnonymously();
    }

    await PreferenceHelper().setIsFirstStart(false);
    setUser(_auth.currentUser);
    //앱 재설치시 signOut 해주기
  }

  Future<String> registerWithEmail(String email, String password) async{
    try{
      AuthCredential authCredential = EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.linkWithCredential(authCredential);
      print('link complete');
      return 'success';
    }on FirebaseAuthException catch (e){
      return e.toString();
    }catch(e){
      return e.toString();
    }
  }
  
  Future<String> signInWithEmail(String email, String password) async{
    try {
      // AuthCredential authCredential = EmailAuthProvider.credential(email: email, password: password);
      // await _auth.currentUser!.linkWithCredential(authCredential);
      // print('link complete');
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      setUser(credential.user);
      return 'success';

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return '이메일을 확인해주세요.';
      } else if (e.code == 'wrong-password') {
        return '비밀번호를 틀렸습니다.';
      }else if(e.code == 'invalid-email'){
        return '이메일 형식이 알맞지 않습니다.';
      }
      else {
        return e.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateNickname(String name)async{
    await _user!.updateDisplayName(name);
    print('updated Username ${name}');
    notifyListeners();
  }

  void setUser(User? user){
    _user = user;
    notifyListeners();
  }

  User? getUser() {
    return _user;
  }
}