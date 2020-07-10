import 'package:easein/addbusiness.dart';
import 'package:easein/listBusiness.dart';
import 'package:easein/profile.dart';
import 'package:flutter/material.dart';

Widget SidebBar(BuildContext context) {
  return Drawer(
      child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Text('Drawer Header'),
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
    ],
  ));
}
