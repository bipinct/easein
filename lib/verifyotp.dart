import 'package:easein/api/errror_handler.dart';
import 'package:easein/api/graphql_handler.dart';
import 'package:easein/api/handlers.dart';
import 'package:easein/components/easein_strings.dart';
import 'package:easein/components/error_alerts.dart';
import 'package:easein/home.dart';
import 'package:easein/main.dart';
import 'package:easein/model/business.dart';
import 'package:easein/model/user.dart';
import 'package:easein/porgressIndicator.dart';
import 'package:easein/profile.dart';
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
            ])));
  }

  verifyOtp() async {
    if(textEditingController.text == ""){
      errorAlert(context, 8);
      return ;
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

          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
                  (Route<dynamic> route) => false
          );

        } else {
          await prefs.setString('profile', null);
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) => UpdateProfile()),
                  (Route<dynamic> route) => false
          );


        }
      } else {
        errorAlert(context, 7);
      }
    } catch (e) {
      errorHandler(context, e.toString());
    }

    setState(() {
      loading = false;
    });
  }
}
