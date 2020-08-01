import 'package:easeinapp/components/easein_theme.dart';
import 'package:flutter/material.dart';

Widget emptyState(String str,Widget widget) {
  return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.only(bottom: 40, top: 40, left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(str, style: EaseInTheme.emptyString,) ,
              ) ,
              widget != null ? widget : Wrap()
            ],
          ),
        ),
      ));
}
