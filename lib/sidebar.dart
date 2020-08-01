import 'package:easeinapp/about.dart';
import 'package:easeinapp/addbusiness.dart';
import 'package:easeinapp/listActivities.dart';
import 'package:easeinapp/listBusiness.dart';
import 'package:easeinapp/model/user.dart';
import 'package:easeinapp/profile.dart';
import 'package:easeinapp/splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget SidebBar({BuildContext context, User userProfile}) {
  Size size = MediaQuery.of(context).size;
  return Drawer(
      child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

          Row(
            children: <Widget>[
              userProfile != null
                  ? Container(
                width: 200,
                child:Text(
                  userProfile.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ) ,
              )
                  : Wrap(),
              SizedBox(width: 10,),

                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => UpdateProfile(user: userProfile,)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(14),
                    child: Icon(Icons.edit,color: Colors.white,),
                  ),

                ),
            ],
          ),

            userProfile != null
                ? Text(
                    userProfile.phone1,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  )
                : Wrap(),
            userProfile != null
                ? Text(
                    userProfile.address,
              style: TextStyle(color: Colors.white54, fontSize: 14),
                  )
                : Wrap(),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      ListTile(
        title: Text('Activity Logs'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ListActivities()));
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
        title: Text('About'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => About()));
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
