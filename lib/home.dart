import 'dart:convert';

import 'package:easein/addbusiness.dart';
import 'package:easein/api/graphql_handler.dart';
import 'package:easein/listBusiness.dart';
import 'package:easein/model/business.dart';
import 'package:easein/porgressIndicator.dart';
import 'package:easein/profile.dart';
import 'package:easein/qrPreView.dart';
import 'package:easein/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool loading = false;
  List<dynamic> activityLogList = [];
  List<Business> businessQR = [];
  Business selectedBusinessForQRView;

  @override
  void initState() {
    super.initState();
    getLocalBusinessList();
    activityLog();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double padTop = businessQR.length > 0 ? 60 : 10;
    print(selectedBusinessForQRView);
    int biznum = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("easein"),
      ),
      drawer: SidebBar(context),
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.only(top: padTop),
            children: <Widget>[
              qrPreview(context, selectedBusinessForQRView),
              ListTile(
                title: Text(
                  "Activity Logs",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ...activityLogList.map((item) {
                print(item);
                Map<String, dynamic> _user = item["user"];
                Map<String, dynamic> _business = item["business"];
                return Container(
                  color: Colors.greenAccent,
                  margin: EdgeInsets.only(top: 10, right: 5, left: 5),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(new DateTime.fromMicrosecondsSinceEpoch(
                                  int.parse(item["createdAt"]) * 1000)
                              .toString()),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(_user["name"] == null ? "-" : _user["name"]),
                          Text(_user["phone1"]),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(_business["shopName"] == null
                              ? "-"
                              : _business["shopName"]),
                          Text(_business["address"] == null
                              ? "-"
                              : _business["address"]),
                        ],
                      )
                    ],
                  ),
                );
//                  ListTile(title: Text( _user["name"] != "null" ? "-" : _user["name"] )
//                    , subtitle: Text("BNNB")
////                Text(item["user"]["phone"]),
//                );
              }).toList(),
            ],
          ),
          Container(
            color: Colors.lime,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ...businessQR.map((Business bis) => Material(
                      // pause button (round)
                      borderRadius: BorderRadius.circular(50),
                      // change radius size
                      color: Colors.blue,
                      //button colour
                      child: InkWell(
                        splashColor: Colors.blue[900],
                        // inkwell onPress colour
                        child: SizedBox(
                            width: 40,
                            height: 40,
                            //customisable size of 'button'
                            child: Center(
                              child: Text(
                                (biznum++).toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                        onTap: () {
                          setState(() {
                            if (selectedBusinessForQRView != null && selectedBusinessForQRView.shopName ==
                                bis.shopName)
                              selectedBusinessForQRView = null;
                            else
                              selectedBusinessForQRView = bis;
                          });
                        }, // or use onPressed: () {}
                      ),
                    ))
              ],
            ),
          ),
          easeinProgressIndicator(context, loading)
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _scan,
        tooltip: 'Scan QR',
        child: Icon(Icons.settings_overscan),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
  }

  activityLog() async {
    var activities = await getActivityLog();
    List<dynamic> resp = activities != null && activities["list"] != null
        ? activities["list"]
        : null;
    setState(() {
      loading = false;
      activityLogList = activities["list"];
    });
  }

  getLocalBusinessList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var storedBizlist = prefs.getString("businessList");
    List<Business> allBiz = [];
    if (storedBizlist != null) {
      var bizitems = jsonDecode(storedBizlist);
      print(bizitems);
      for (var i = 0; i < bizitems.length; i++) {
        allBiz.add(Business(
          shopName: bizitems[i]["shopName"],
          publicid: bizitems[i]["publicid"],
          createdAt: bizitems[i]["createdAt"],
          address: bizitems[i]["address"],
        ));
      }
    }
    setState(() {
      businessQR = allBiz;
    });
  }
}
