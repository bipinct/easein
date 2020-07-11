import 'dart:convert';

import 'package:easein/api/graphql_handler.dart';
import 'package:easein/model/business.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListBusiness extends StatefulWidget {
  @override
  _ListBusinessState createState() => _ListBusinessState();
}

class _ListBusinessState extends State<ListBusiness> {
  List<Business> businessList = [];
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loading = true;
    });
    getBusinessList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
//        backgroundColor: Color(0xFF5c00d2),
        appBar: new AppBar(
          title: Text("My Businesses"),
        ),
        body: Stack(children: <Widget>[
          businessList.length > 0
              ? ListView.separated(
                  itemCount: businessList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: Colors.purple,
                  ),
                  itemBuilder: (context, i) {
                    return businessList[i] != null
                        ? ListTile(
                            title: Text(businessList[i].shopName),
                            subtitle: businessList[i].address != null
                                ? Text(businessList[i].address)
                                : Text(""),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {},
                            onLongPress: () {},
                            leading: RaisedButton(
                              // qr icon
                              child: Icon(Icons.queue_play_next),
                              onPressed: () {},
                            ))
                        : Container(
                            height: 0,
                            width: 0,
                          );
                  },
                )
              : Wrap(),
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
        ]));
  }

  getBusinessList() async {
    var businessesLF = await getBusiness();
    List<dynamic> resp = businessesLF != null && businessesLF["list"] != null
        ? businessesLF["list"]
        : null;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Business> fetchedBusinessList = [];
    var bizLis = [];
    for (var i = 0; i < businessesLF["list"].length; i++) {
      Business biz = Business(
          address: businessesLF["list"][i]["address"],
          shopName: businessesLF["list"][i]["shopName"],
          createdAt: businessesLF["list"][i]["createdAt"],
          publicid: businessesLF["list"][i]["publicid"]);
      fetchedBusinessList.add(biz);
    }



    prefs.setString("businessList", jsonEncode(fetchedBusinessList));

    setState(() {
      loading = false;
      businessList = fetchedBusinessList;
    });
  }
}
