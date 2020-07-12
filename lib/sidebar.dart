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
        child: Row(
          children: <Widget>[
            Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
            userProfile !=null ?
            Text(
              userProfile.name,
              style: TextStyle(color: Colors.white),
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
      ListTile(
        title: Text('My Visits'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        title: Text('My Visits'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        title: Text('My QR'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
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
      ListTile(
        title: Text('Profile'),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UpdateProfile()));
        },
      ),
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
