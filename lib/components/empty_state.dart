import 'package:flutter/material.dart';

Widget emptyState(String str) {
  return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.only(bottom: 40, top: 40, left: 20, right: 20),
        child: Center(
          child: Text(str),
        ),
      ));
}
