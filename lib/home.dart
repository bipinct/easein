import 'package:easein/addbusiness.dart';
import 'package:easein/api/graphql_handler.dart';
import 'package:easein/listBusiness.dart';
import 'package:easein/profile.dart';
import 'package:easein/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:qr_flutter/qr_flutter.dart';

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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activityLog();
//    this._scan();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("easein"),
      ),
      drawer: SidebBar(context),
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.only(top: 50),
            children: <Widget>[
              QrImage(
                data: "1234567890",
                version: QrVersions.auto,
                size: size.width,
              ),
              ListTile(
                title: Text(
                  "Activity Logs",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ...activityLogList.map((item){
                print(item);
                Map<String, dynamic> _user = item["user"];
                Map<String, dynamic> _business = item["business"];
                return  Container(
                  color: Colors.greenAccent,
                  margin: EdgeInsets.only(top: 10,right: 5,left: 5),
                  padding: EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text( new DateTime.fromMicrosecondsSinceEpoch( int.parse( item["createdAt"]) * 1000).toString() ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text( _user["name"] == null ? "-" : _user["name"] ),
                          Text(_user["phone1"]  ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text( _business["shopName"] == null ? "-" : _business["shopName"] ),
                          Text( _business["address"] == null ? "-" : _business["address"] ),
                        ],
                      )

                    ],
                  ),
                );
//                  ListTile(title: Text( _user["name"] != "null" ? "-" : _user["name"] )
//                    , subtitle: Text("BNNB")
////                Text(item["user"]["phone"]),
//                );
              }



              ).toList(),
            ],
          ),
          Container(
            color: Colors.lime,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text("Biz 1"),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text("Biz 2"),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text("Biz 3"),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text("Biz 4"),
                  onPressed: () {},
                )
              ],
            ),
          ),
          loading
              ? Container(
                  width: size.width,
                  height: size.height,
                  color: Colors.black38,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Wrap()
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
}
