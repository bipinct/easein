import 'dart:convert';
import 'package:easein/api/graphql_handler.dart';
import 'package:easein/api/handlers.dart';
import 'package:easein/components/activityLogList.dart';
import 'package:easein/components/businessListForQuickNavigation.dart';
import 'package:easein/components/easein_strings.dart';
import 'package:easein/components/easein_theme.dart';
import 'package:easein/components/error_alerts.dart';
import 'package:easein/model/business.dart';
import 'package:easein/model/user.dart';
import 'package:easein/porgressIndicator.dart';
import 'package:easein/qrPreView.dart';
import 'package:easein/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = false;
  List<dynamic> activityLogList = [];
  List<Business> businessQR = [];
  Business selectedBusinessForQRView;
  User userProfile;

  @override
  void initState() {
    super.initState();
    getLocalBusinessList();
    losdBusiness();
    activityLog();
    loadUserInfo();
  }

  loadUserInfo() async {
    User _up = await getProfile();
    setState(() {
      userProfile = _up;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double padTop = businessQR.length > 0 ? 60 : 10;
    print(selectedBusinessForQRView);
    int biznum = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(EaseinString.appName),
      ),
      drawer: SidebBar(context: context, userProfile: userProfile),
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.only(top: padTop),
            children: <Widget>[
              qrPreview(context, selectedBusinessForQRView),
              ListTile(
                title: Text(
                  EaseinString.titleActivityLogs,
                  style: EaseInTheme.Heading,

                ),
                trailing: FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: (){
                    activityLog();
                  },
                ),
              ),
              ...activityLogListBuilder(context, activityLogList)
            ],
          ),
          businessListForQuickNavigation(
              context, businessQR, updateStore, selectedBusinessForQRView),
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
    setState(() {
      loading = true;
    });
    var now = new DateTime.now();
    try {
      var result =
      await addActivityLog(token: barcode, requestId: now.toString());
      if(result != null && result["status"] != null && result["status"] == true){
        await activityLog();
      }

    } catch (e) {
      print(" ... error in network call.....");
      print(e);
      int errorType = 4;
      if (e.toString().indexOf("Failed host lookup") != -1) {
        errorType = 1;
      }
      errorAlert(context, errorType);
    }
    setState(() {
      loading = false;
    });
  }

  updateStore(_datafrom) {
    setState(() {
      selectedBusinessForQRView = _datafrom;
    });
  }

  activityLog() async {
    var activities = await getActivityLog();
    print("::::::::::::::::::::::::::::::::::::::::");
    print(activities);
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
            qrcodeString: bizitems[i]["qrcodeString"],
            isSelected: false));
      }
    }
    setState(() {
      businessQR = allBiz;
    });
  }

  losdBusiness() async {
    List<Business> bizList = await getBusinessList();

    setState(() {
      loading = false;
      businessQR = bizList;
    });
  }
}
