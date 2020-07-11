import 'package:flutter/material.dart';

Widget easeinProgressIndicator(BuildContext context, bool loading) {
  Size size = MediaQuery.of(context).size;
  return loading
      ? Container(
          width: size.width,
          height: size.height,
          color: Colors.black38,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      : Wrap();
}
