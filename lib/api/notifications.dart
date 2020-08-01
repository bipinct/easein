import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// source: https://github.com/MaikuB/flutter_local_notifications/blob/master/example/lib/main.dart
// TODO: make different notification for app
class CustomNotification {
  CustomNotification() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  Future<String> _downloadAndSaveImage(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(url);
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> makeNotification(data) async {
    print(".....make notificaiton..........");
    print(data);
    var _nbody = data["notification"];
    var _ndata = data["data"];
    var _title = _nbody["title"] ?? "Easein";
    var _description = _nbody["body"];
    var _image = _ndata["image"];
    var _action = _ndata["action"];
    var _type = _ndata["type"];
    var _id = _ndata["id"] !=null ? _ndata["id"] : "0" ;
    var _contentid = _ndata["contentid"];
    var largeIconPath;
    var bigPicPath;
    if (_image != "null" && _image != null)
      largeIconPath = await _downloadAndSaveImage(_image, 'largeIcon');
    if (_image != "null" && _image != null)
      bigPicPath = await _downloadAndSaveImage(_image, 'bigPicture');
    var androidPlatformChannelSpecifics;
    if (_image != "null" && _image != null) {
      var bigPictureStyleInformation = BigPictureStyleInformation(
        bigPicPath
          ,contentTitle: _title,summaryText: _description,htmlFormatSummaryText: true
      );

      androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "easein","test",'test 2', largeIcon: largeIconPath, styleInformation: bigPictureStyleInformation
      );

//          _id, 'follow', 'glue follow',
//          largeIcon: largeIconPath,
//          largeIconBitmapSource: BitmapSource.FilePath,
//          style: AndroidNotificationStyle.BigPicture,
//          styleInformation: bigPictureStyleInformation);
    } else {
      var bigTextStyleInformation = BigTextStyleInformation(_description,
          htmlFormatBigText: true,
          contentTitle: _title,
          htmlFormatContentTitle: true,
          summaryText: _description,
          htmlFormatSummaryText: true);
      androidPlatformChannelSpecifics = AndroidNotificationDetails(
          _id, 'follow', 'glue follow',
          largeIcon: largeIconPath,
//          style: AndroidNotificationStyle.BigText,
          styleInformation: bigTextStyleInformation);
    }

    var platformChannelSpecifics =
    NotificationDetails(androidPlatformChannelSpecifics, null);

    await flutterLocalNotificationsPlugin.show(
        int.parse(_id), _title, _description, platformChannelSpecifics);
  }

  Future<void> _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // update server api about notification received
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  saveNotification() async{


  }
}