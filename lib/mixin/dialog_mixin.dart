
import 'package:flutter/material.dart';

mixin DialogMixin{
  Future<void> showAlertDialog(BuildContext context,{required String title, required String content})async{
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('네'),
              )
            ],
          );
        });
  }

}