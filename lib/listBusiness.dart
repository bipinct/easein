import 'dart:convert';

import 'package:easein/api/handlers.dart';
import 'package:easein/model/business.dart';
import 'package:easein/porgressIndicator.dart';
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
    super.initState();
    setState(() {
      loading = true;
    });
    loadFromCache();
    loadBusiness();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
          easeinProgressIndicator(context, loading)
        ]));
  }

  loadFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _businessList = prefs.getString("businessList");
    if (businessList != null) {
      var _localBizList = jsonDecode(_businessList);
      List<Business> _bizList = [];
      for (var i = 0; i < _localBizList.length; i++) {
        Business biz = Business(
            address: _localBizList[i]["address"],
            shopName: _localBizList[i]["shopName"],
            createdAt: _localBizList[i]["createdAt"],
            publicid: _localBizList[i]["publicid"],
            qrcodeString: _localBizList[i]["qrcodeString"],
            isSelected: false);
        _bizList.add(biz);
      }
      setState(() {
        loading = false;
        businessList = _bizList;
      });
    }
  }

  loadBusiness() async {
    List<Business> bizList= [];
    try {
      bizList = await getBusinessList();
      print(bizList);
    } catch (e) {}

    setState(() {
      loading = false;
      businessList = bizList;
    });
  }
}
