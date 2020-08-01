import 'dart:convert';

import 'package:easeinapp/addbusiness.dart';
import 'package:easeinapp/api/handlers.dart';
import 'package:easeinapp/components/easein_strings.dart';
import 'package:easeinapp/components/easein_theme.dart';
import 'package:easeinapp/components/empty_state.dart';
import 'package:easeinapp/model/business.dart';
import 'package:easeinapp/porgressIndicator.dart';
import 'package:easeinapp/viewbusiness.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListBusiness extends StatefulWidget {
  @override
  _ListBusinessState createState() => _ListBusinessState();
}

class _ListBusinessState extends State<ListBusiness> {
  List<Business> allBusinessList = [];
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddBusiness()));
          },
          tooltip: 'Add Business',
          child: Icon(Icons.edit),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Stack(children: <Widget>[
              allBusinessList.length > 0
                  ? ListView.separated(
                      itemCount: allBusinessList.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        color: Colors.purple.shade200,
                      ),
                      itemBuilder: (context, i) {
                        return allBusinessList[i] != null
                            ? ListTile(
                                title: Text(allBusinessList[i].shopName),
                                subtitle: allBusinessList[i].address != null
                                    ? Text(allBusinessList[i].address)
                                    : Text(""),
                                trailing: FlatButton(
                                  child: Icon(Icons.delete_outline),
                                  onPressed: () {
                                    Alert(
                                      context: context,
                                      title: "Confirm delete",
                                      desc:
                                          "Are you sure to delete this business",
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "Confirm",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          onPressed: () {
                                            deleteLocalBusiness(
                                                allBusinessList[i]);
                                            Navigator.pop(context);
                                          },
                                          width: 120,
                                        ),
                                        DialogButton(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          width: 120,
                                        ),
                                      ],
                                    ).show();
                                  },
                                ),
                                onTap: () {
                                  // view business details
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewBusiness(
                                              business: allBusinessList[i])));
                                },
                                onLongPress: () {},
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.deepPurple,
                                  child: Text(
                                    avatarImage(allBusinessList[i].shopName),
                                    style: TextStyle(color: Colors.white),
                                    key: new Key("avt_" + i.toString()),
                                  ),
                                ),
                              )
                            : Container(
                                height: 0,
                                width: 0,
                              );
                      },
                    )
                  : Center(
                      child: Wrap(children: <Widget>[
                        emptyState(
                            EaseinString.noBusiness,
                            RaisedButton(
                              color: EaseInTheme.buttonColors,
                              textColor: Colors.white,
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddBusiness())),
                              child: Text(
                                EaseinString.addBusiness,
                              ),
                            ))
                      ]),
                    ),
              easeinProgressIndicator(context, loading)
            ])));
  }

  loadFromCache() async {
    if(mounted) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var _businessList = prefs.getString("businessList");
      if (allBusinessList != null) {
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
          allBusinessList = _bizList;
        });
      }
    }
  }

  deleteLocalBusiness(Business business) {
    setState(() {
      allBusinessList
          .removeWhere((element) => element.publicid == business.publicid);
    });
    saveBusinessToCache(allBusinessList);
  }

  loadBusiness() async {
    if (mounted) {
      List<Business> bizList = [];
      try {
        bizList = await getBusinessList();
      } catch (e) {}

      setState(() {
        loading = false;
        allBusinessList = bizList;
      });
    }
  }
}
