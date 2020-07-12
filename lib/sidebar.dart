import 'package:easein/addbusiness.dart';
import 'package:easein/listBusiness.dart';
import 'package:easein/model/user.dart';
import 'package:easein/profile.dart';
import 'package:easein/splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget SidebBar({BuildContext context, User userProfile}) {
  return Drawer(
      child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'PROFILE',
              style: TextStyle(color: Colors.white24,fontWeight: FontWeight.bold),
            ),
            userProfile !=null ?
            Text(
              userProfile.name,
              style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),
            ): Wrap(),
            userProfile !=null ?
            Text(
              userProfile.phone1,
              style: TextStyle(color: Colors.white70,fontSize: 16),
            ): Wrap(),

            userProfile !=null ?
            Text(
              userProfile.address,
              style: TextStyle(color: Colors.white54,fontSize: 14),
            ): Wrap(),

          ],
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      ListTile(
        title: Text('My Profile'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
//      ListTile(
//        title: Text('My Visits'),
//        onTap: () {
//          Navigator.pop(context);
//        },
//      ),
//      ListTile(
//        title: Text('My Visits'),
//        onTap: () {
//          Navigator.pop(context);
//        },
//      ),
//      ListTile(
//        title: Text('My QR'),
//        onTap: () {
//          Navigator.pop(context);
//        },
//      ),
      ListTile(
        title: Text('My Businesses'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ListBusiness()));
        },
      ),
      ListTile(
        title: Text('Add Business'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddBusiness()));
        },
      ),
//      ListTile(
//        title: Text('Profile'),
//        onTap: () {
//          Navigator.push(context,
//              MaterialPageRoute(builder: (context) => UpdateProfile()));
//        },
//      ),
      ListTile(
        title: Text('Logout'),
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("x-token");
          prefs.remove("businessList");
          prefs.clear();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Splash()),
              ModalRoute.withName("/"));
        },
      ),
    ],
  ));
}
