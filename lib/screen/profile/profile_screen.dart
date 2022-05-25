import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/mixin/dialog_mixin.dart';
import 'package:flutter_test_chatapp/state/user_state.dart';
import 'package:flutter_test_chatapp/widget/appbar/default_appbar_widget.dart';
import 'package:flutter_test_chatapp/widget/progress_dialog.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with DialogMixin{
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context,listen: true);
    bool isAnony = userState.getUser().isAnonymous;

    return Scaffold(
        appBar: getDefaultAppbar(titleText: '프로필'),
        body: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person,size: 100,color: Colors.black38,),
                radius: 70,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(!isAnony)
                Container(width: 20,),
                SizedBox(width: 10,),
                Text(
                  isAnony?'익명 사용자':userState.getUser().displayName??'사용자',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 10,),

                if(!isAnony)
                GestureDetector(
                  onTap: _onTapEditNickname,
                  child: Icon(Icons.edit),
                )
              ],
            ),

            SizedBox(height: 30,),
            MaterialButton(onPressed: _onPressedLonginButton,child: Text(isAnony?'로그인':'로그아웃'),height: 60,)
          ],
        ));
  }

  void _onTapEditNickname() async{
    ProgressDialog progressDialog = ProgressDialog(context);
    UserState userState = Provider.of<UserState>(context,listen: false);
    final result = await showTextDialog(context, title: '닉네임 수정', hintText: 'ex)끄뉵쟁이',initialText: userState.getUser().displayName??'',maxLength: 16);

    if(result !=null){
      progressDialog.show();
      await userState.updateNickname(result);
      progressDialog.dismiss();
    }
  }

  void _onPressedLonginButton() async{
    UserState userState = Provider.of<UserState>(context,listen: false);

    if(userState.getUser().isAnonymous){
      Navigator.pushNamed(context, Routes.login);
    }else{
      await userState.signOut();
    }
  }
}
