import 'dart:convert';

import 'package:easein/api/errror_handler.dart';
import 'package:easein/api/graphql_handler.dart';
import 'package:easein/components/error_alerts.dart';
import 'package:easein/porgressIndicator.dart';
import 'package:easein/terms.dart';
import 'package:easein/verifyotp.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController textEditingController = TextEditingController();
  bool loading = false;
  bool checkedValue = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFF5c00d2),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xff1A237E), Color(0xff0D47A1)]),
              image: DecorationImage(
                  image: AssetImage("assets/bg.jpg"),
//              fit: BoxFit.cover,
                  repeat: ImageRepeat.repeatX),
            ),
            child: Stack(children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.all(13.0),
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, spreadRadius: 8),
                    ],
                  ),
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
                      SizedBox(
                        height: 60,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              width: size.width - 100,
                              height: 60,
                              child:
                              CheckboxListTile(
                                title: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: <Widget>[
                                    Text("I agree ",style: TextStyle(fontSize: 11),),
                                    GestureDetector(
                                      onTap: ()=>Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Terms())),
                                      child: Text("terms and condition",style: TextStyle(fontSize: 11),)
                                    )

                                  ],
                                ),
                                value: checkedValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    checkedValue = newValue;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                              )
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[

                          RaisedButton(
                            color: Colors.greenAccent,
                            disabledColor: Colors.greenAccent.shade400,
                            onPressed: checkedValue ?  () {
                              print("..done....");
                              signIn();
                            }: null,
                            child: Text("Get OTP"),
                          )

                        ],
                      )
                    ],
                  ),
                ),
              ),
              easeinProgressIndicator(context, loading)
            ])));
  }

  signIn() async {
    setState(() {
      loading = true;
    });
    try {
      var checkPhoneNumber = _phoneNumberValidator(textEditingController.text);
      if (checkPhoneNumber == null) {
        var result = await signInEnterPhoneNumber(textEditingController.text);
        if (result != null && result["status"] == true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VerifyOTP(phoneNumber: textEditingController.text)));
        } else {}
      } else {
        errorAlert(context, 6);
      }
    } catch (e) {
      errorHandler(context, e.toString());
    }
    setState(() {
      loading = false;
    });
  }

  String _phoneNumberValidator(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
