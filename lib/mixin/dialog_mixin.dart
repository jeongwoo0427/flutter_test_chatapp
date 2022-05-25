
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

  Future<dynamic> showTextDialog(BuildContext context,{required String title,required String hintText,String initialText ='',int? maxLength})async{
    TextEditingController textController = TextEditingController(text: initialText);

    return await showDialog(
        context: context,
        builder: (context) {
          Size screenSize = MediaQuery.of(context).size;
          return Dialog(
            child: Container(
              height: 200,
              width: 100,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    TextField(
                      maxLength: maxLength,
                      controller: textController,
                      decoration: InputDecoration(hintText: hintText),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        MaterialButton(
                          onPressed: (){
                            if (textController.text.trim() == '') {
                              showAlertDialog(context, title: '주의', content: '최소 1글자 이상입니다.');
                              return;
                            }
                            Navigator.pop(context,textController.text);},
                          child: Text('완료'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
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