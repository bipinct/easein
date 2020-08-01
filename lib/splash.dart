import 'dart:async';

import 'package:easeinapp/addbusiness.dart';
import 'package:easeinapp/components/easein_strings.dart';
import 'package:easeinapp/home.dart';
import 'package:easeinapp/listBusiness.dart';
import 'package:easeinapp/login.dart';
import 'package:easeinapp/main.dart';
import 'package:easeinapp/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  double logoWidth = 160.0;
  bool loadingHome = true;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Material(
        child: Container(
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
            child: Stack(
              children: <Widget>[
                Container(
//                    decoration: BoxDecoration(
//
//                        ),
                    child: Center(
                        child: AnimatedContainer(
                  duration: Duration(milliseconds: 700),
                  onEnd: () {
                    setState(() {
                      logoWidth = logoWidth == 160 ? 155.0 : 160;
                    });
                  },
                  curve: Curves.easeInOut,
                  width: logoWidth,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.indigo,
                        blurRadius: 300,
                        offset: Offset(0.3, 0.6))
                  ]),
                  child: Image(
                    image: AssetImage("assets/logo.png"),
                  ),
                ))),
                loadingHome
                    ? Positioned(
                        bottom: 100,
                        right: (_width - 30) / 2,
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(),
                      )
                    : Column(),
                Positioned(
                    bottom: 10,
                    width: _width,
                    child: Wrap(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image(
                              image:
                                  AssetImage("assets/Digital_India_logo.png"),
                            ),
                            SizedBox(width: 20,),
                            Image(
                              image: AssetImage("assets/rotibank.jpeg"),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        SizedBox(
                          height: 20,
                          width: 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(EaseinString.copyrightString,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "SourceSerifPro",
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white70,
                                )),
                          ],
                        ),
                      ],
                    ))
              ],
            )));
  }

  startTimer() async {
    Timer(Duration(seconds: 5), () => navigate());
  }

  navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('x-token');
    String profile = prefs.getString('profile');
    if (token != null) {
      if (profile == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UpdateProfile()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}
