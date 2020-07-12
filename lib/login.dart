import 'dart:convert';

import 'package:easein/api/graphql_handler.dart';
import 'package:easein/components/error_alerts.dart';
import 'package:easein/porgressIndicator.dart';
import 'package:easein/verifyotp.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController textEditingController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFF5c00d2),
        body: Stack(children: <Widget>[
          Center(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.all(13.0),
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Wrap(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(fontSize: 30),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          width: size.width - 100,
                          height: 60,
                          child: TextField(
                            controller: textEditingController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            maxLengthEnforced: true,
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.greenAccent,
                        onPressed: () {
                          print("..done....");
//
                          signIn();
                        },
                        child: Text("Get OTP"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          easeinProgressIndicator(context, loading)
        ]));
  }

  signIn() async {
    setState(() {
      loading = true;
    });
    try {
      var result = await signInEnterPhoneNumber(textEditingController.text);
      print(result);
      if (result != null && result["status"] == true) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    VerifyOTP(phoneNumber: textEditingController.text)));
      } else {}
    } catch (e) {
      print(" ... error in network call.....");
      print(e);
      int errorType = 0;
      if(e.toString().indexOf("Failed host lookup") != -1){
        errorType = 1;
      }
      errorAlert(context, errorType);
    }

    setState(() {
      loading = false;
    });
  }
}
