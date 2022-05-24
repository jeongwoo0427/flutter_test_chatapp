import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper{


  Future<bool> getIsFirstStart() async{
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('isFirst') ?? true;
  }
  Future setIsFirstStart(bool isFirst) async{
    final pref = await SharedPreferences.getInstance();
    return pref.setBool('isFirst', isFirst);
  }

}