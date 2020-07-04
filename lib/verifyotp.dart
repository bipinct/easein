import 'package:easein/main.dart';
import 'package:flutter/material.dart';

class VerifyOTP extends StatefulWidget {
  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFF5c00d2),
        body: Center(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.all(13.0),
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: Wrap(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Verify",style: TextStyle(fontSize: 30),)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        width: size.width-100,
                        height: 60,
                        child: TextField(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage( title: "HomePage",) ));
                      },
                      child: Text("verify"),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
