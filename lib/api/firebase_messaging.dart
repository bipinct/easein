import 'package:easein/api/graphql_handler.dart';
import 'package:easein/api/notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'dart:io' show Platform;

//import 'package:social/utils/notification.dart'; //at the top

// TODO: save the generated fcm token on server
// TODO: logic for different push received
// TODO: make notification configurable on app (for version 2)

class FCMHelper {
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  final CustomNotification customNotification = new CustomNotification();
  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fcmtoken = await prefs.getString('fcm');

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    if (fcmtoken == null) {
      _firebaseMessaging.getToken().then((token) async {
        print("...fcm token recieved.....");
        print(token);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('fcm', token);
      });
    }

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        // save notification to list
        customNotification.makeNotification(message);
      },
      onResume: (Map<String, dynamic> message) {
        print('..on resume.. $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('..on launch $message');
      },
    );
  }

  void pushFCMTokenToServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fcmtoken = await prefs.getString('fcm');
    print("FCMMM" + fcmtoken);
    String os = Platform.operatingSystem;
    // TODO: check value for IOS
    if (fcmtoken != null) await registerFCMToken(token: fcmtoken,devicetype: os);
  }



}