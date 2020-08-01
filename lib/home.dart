import 'dart:convert';
import 'package:easeinapp/api/caching.dart';
import 'package:easeinapp/api/errror_handler.dart';
import 'package:easeinapp/api/firebase_messaging.dart';
import 'package:easeinapp/api/graphql_handler.dart';
import 'package:easeinapp/api/handlers.dart';
import 'package:easeinapp/components/activityLogList.dart';
import 'package:easeinapp/components/businessListForQuickNavigation.dart';
import 'package:easeinapp/components/easein_strings.dart';
import 'package:easeinapp/components/easein_theme.dart';
import 'package:easeinapp/components/error_alerts.dart';
import 'package:easeinapp/model/business.dart';
import 'package:easeinapp/model/user.dart';
import 'package:easeinapp/porgressIndicator.dart';
import 'package:easeinapp/qrPreView.dart';
import 'package:easeinapp/sidebar.dart';
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
    loadBusiness();
    cachedActivity();
//    activityLog();
    loadUserInfo();
    loadActivity();
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
    double padTop = businessQR.length > 0 ? 80 : 10;

    int biznum = 1;
    return
      Scaffold(
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
                  onPressed: () {
                    loadActivity();
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
        child: Image(
          image: AssetImage("assets/scanicon.png"),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    if(barcode != "") {
      setState(() {
        loading = true;
      });
      var now = new DateTime.now();
      try {
        var result =
        await addActivityLog(token: barcode, requestId: now.toString());
        if (result != null &&
            result["status"] != null &&
            result["status"] == true) {
          await loadActivity();
        }
      } catch (e) {
        errorHandler(context, e.toString());
      }
      setState(() {
        loading = false;
      });
    }
  }

  updateStore(_datafrom) {
    setState(() {
      selectedBusinessForQRView = _datafrom;
    });
  }

  loadActivity() async {
    var _loadFromApi = await loadActivityLogFromApi();
    setState(() {
      loading = false;
      activityLogList = _loadFromApi;
    });
  }

  cachedActivity() async {
    var _cha = await loadActivityFromCache();
    setState(() {
      activityLogList = _cha;
    });
  }

  getLocalBusinessList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var storedBizlist = prefs.getString("businessList");
    var businessSelected;
    List<Business> allBiz = [];
    if (storedBizlist != null) {
      var bizitems = jsonDecode(storedBizlist);

      for (var i = 0; i < bizitems.length; i++) {
        allBiz.add(Business(
            shopName: bizitems[i]["shopName"],
            publicid: bizitems[i]["publicid"],
            createdAt: bizitems[i]["createdAt"],
            address: bizitems[i]["address"],
            qrcodeString: bizitems[i]["qrcodeString"],
            isSelected: bizitems[i]["isSelected"] || false));
      }
      businessSelected = allBiz.firstWhere(
          (Business element) => element.isSelected == true,
          orElse: () => null);
    }
    setState(() {
      businessQR = allBiz;
      selectedBusinessForQRView = businessSelected;
    });
  }

  loadBusiness() async {
    List<Business> bizList = await getBusinessList();
    var businessSelected = bizList.firstWhere(
        (Business element) => element.isSelected == true,
        orElse: () => null);
    setState(() {
      loading = false;
      businessQR = bizList;
    });
  }
}
