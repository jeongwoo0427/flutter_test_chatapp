
import 'package:flutter/material.dart';

import '../widget/title_card_widget.dart';

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

  Future<dynamic> showCardDialog(
      BuildContext context, {
        double? height = 800,
        double width = 300,
        double titleHeight = 50,
        Widget? titleChild,
        Widget? contentChild,
        Color? titleColor,
        Color? contentColor,
        double borderRadiusCircular = 10,
        double elevation = 5,
      }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: Colors.transparent,
            child: TitleCardWidget(
              height: height,
              width: width,
              titleHeight: titleHeight,
              titleChild: titleChild,
              contentChild: contentChild,
              titleColor: titleColor,
              contentColor: contentColor,
              borderRadiusCircular: borderRadiusCircular,
              elevation: elevation,
            ),
          );
        });
  }

}