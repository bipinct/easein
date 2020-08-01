import 'package:easeinapp/api/firebase_messaging.dart';
import 'package:easeinapp/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
FCMHelper  fcmHelper = new FCMHelper();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  fcmHelper.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      color: Color(0xFF5c00d2),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash()
    );
  }
}

