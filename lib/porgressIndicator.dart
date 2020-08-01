import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget easeinProgressIndicator(BuildContext context, bool loading) {
  Size size = MediaQuery.of(context).size;
  return loading
      ? Container(
          width: size.width,
          height: size.height,
          color: Colors.black38,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SpinKitWave(
                  color: Colors.white, type: SpinKitWaveType.start),
            ],
          )
//            CircularProgressIndicator(),
              ),
        )
      : Wrap();
}
