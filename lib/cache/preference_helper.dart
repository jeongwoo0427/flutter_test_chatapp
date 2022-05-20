import 'package:shared_preferences/shared_preferences.dart';

class PrefernceHelper{

  Future<String> getNickname() async{
    final pref = await SharedPreferences.getInstance();
    return pref.getString('nickname')??'';
  }

  Future setNickname(String nickname) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('nickname',nickname);
  }

}