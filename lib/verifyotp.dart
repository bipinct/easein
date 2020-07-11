import 'package:easein/api/graphql_handler.dart';
import 'package:easein/home.dart';
import 'package:easein/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyOTP extends StatefulWidget {
  VerifyOTP({Key key, this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  bool loading = false;
  TextEditingController textEditingController = TextEditingController();

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
                        "Verify",
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
                          verifyOtp();
                        },
                        child: Text("verify"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          loading
              ? Container(
                  width: size.width,
                  height: size.height,
                  color: Colors.black38,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Wrap()
        ]));
  }

  verifyOtp() async {
    setState(() {
      loading = true;
    });
    var result =
        await signInVerifyOTP(widget.phoneNumber, textEditingController.text);
    print("ppppppppppp");
    print(result);
    if (result != null && result["status"] == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('x-token', result["token"]);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {}
    setState(() {
      loading = false;
    });
  }
}
