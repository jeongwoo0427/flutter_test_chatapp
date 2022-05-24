import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper{

  Future<String> getNickname() async{
    final pref = await SharedPreferences.getInstance();
    return pref.getString('nickname')??'';
  }

  Future setNickname(String nickname) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('nickname',nickname);
  }

  Future setEmail(String email) async{
    final pref = await SharedPreferences.getInstance();
    pref.setString('email', email);
  }

}