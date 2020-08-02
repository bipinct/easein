import 'package:easeinapp/api/errror_handler.dart';
import 'package:easeinapp/api/graphql_handler.dart';
import 'package:easeinapp/api/handlers.dart';
import 'package:easeinapp/components/easein_strings.dart';
import 'package:easeinapp/components/error_alerts.dart';
import 'package:easeinapp/home.dart';
import 'package:easeinapp/login.dart';
import 'package:easeinapp/main.dart';
import 'package:easeinapp/model/business.dart';
import 'package:easeinapp/model/user.dart';
import 'package:easeinapp/porgressIndicator.dart';
import 'package:easeinapp/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, spreadRadius: 8),
                      ],
                    ),
                    margin: EdgeInsets.all(13.0),
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    child: Wrap(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              EaseinString.enterOTP,
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
                                  maxLength: 5,
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
                              child: Text(EaseinString.verify),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                easeinProgressIndicator(context, loading)
              ]))),
    );
  }

  verifyOtp() async {
    if (textEditingController.text == "") {
      errorAlert(context, 8, null);
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      var result =
          await signInVerifyOTP(widget.phoneNumber, textEditingController.text);
      if (result != null && result["status"] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('x-token', result["token"]);
        await prefs.setString('phonenumber', widget.phoneNumber);

        if (result["user"] != null &&
            result["user"]["name"] != "" &&
            result["user"]["name"] != null) {
          await saveProfileToCache(
              name: result["user"]["name"],
              address: result["user"]["address"],
              email: result["user"]["email1"],
              phone: result["user"]["phone1"],
              createdAt: result["user"]["createdAt"]);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage()),
              (Route<dynamic> route) => false);
        } else {
          await prefs.setString('profile', null);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => UpdateProfile()),
              (Route<dynamic> route) => false);
        }
      } else {
        errorAlert(context, 7, null);
      }
    } catch (e) {
      errorHandler(context, e.toString());
    }

    setState(() {
      loading = false;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to go back'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Login()),
                    (Route<dynamic> route) => false),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
