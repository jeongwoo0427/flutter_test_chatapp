import 'package:flutter/material.dart';

PreferredSizeWidget getDefaultAppbar({required String titleText,List<Widget>? actions}){
  return AppBar(
    centerTitle: true,
    title: Text(titleText),
    actions: actions,
  );
}