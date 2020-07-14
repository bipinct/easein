import 'package:easein/components/easein_strings.dart';
import 'package:easein/components/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List activityLogListBuilder(BuildContext context, activityLogList) {
  final DateFormat formatter = DateFormat('dd MMMM h:mm a ');
  Size size = MediaQuery.of(context).size;
  int i = 0;
  return activityLogList.length > 0
      ? activityLogList.map((item) {
          i++;
          Map<String, dynamic> _user = item["user"];
          Map<String, dynamic> _business = item["business"];
          print(item);
          return item['isBusiness']
              ? userInfoCardForBusiness(
                  item, size, _business, _user, formatter, i)
              : businessInfoCardForUser(
                  item, size, _business, _user, formatter, i);
        }).toList()
      : [emptyState(EaseinString.noActivityLogs)];
}

Widget userInfoCardForBusiness(item, size, _business, _user, formatter, i) {
//  String _un = _user["name"].split(" ").map((e) => e.substring(1,0)).join("").toUpperCase();
  return Card(
      elevation: 20,
      color: Colors.deepPurpleAccent,
      shadowColor: Colors.black38,
      borderOnForeground: true,
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 5, left: 5),
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  formatter
                      .format(new DateTime.fromMicrosecondsSinceEpoch(
                          int.parse(item["createdAt"]) * 1000))
                      .toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
//            Row(children: <Widget>[
//              Container(
//                  width: size.width - 40,
//                  child: Text(
//                    _business["shopName"] == null ? "-" : _business["shopName"],
//                    style: TextStyle(fontSize: 20),
//                    overflow: TextOverflow.fade,
//                  ))
//            ]),
//            SizedBox(
//              height: 10,
//            ),
//            Row(children: <Widget>[
//              Container(
//                  width: size.width - 40,
//                  child: Text(
//                    _business["address"] == null ? "-" : _business["address"],
//                    style: TextStyle(fontSize: 14),
//                    overflow: TextOverflow.fade,
//                  ))
//            ]),
//            SizedBox(
//              height: 10,
//            ),
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.brown.shade800,
                  child: Text(
                    avatarImage(_user["name"]),
                    key: new Key("avt_" + i.toString()),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                    width: size.width - 100,
                    child: Text(
                      _user["name"] == null ? "-" : _user["name"],
                      style: TextStyle(fontSize: 16,color: Colors.white),
                      overflow: TextOverflow.fade,
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 60,
                ),

                Container(
                    width: size.width - 100,
                    child: Text(
                      _user["address"] != null ? _user["address"] : "NA",
                      style: TextStyle(fontSize: 14,color: Colors.white54),
                      overflow: TextOverflow.fade,
                    ))
              ],
            ),
          ],
        ),
      ));
}

Widget businessInfoCardForUser(item, size, _business, _user, formatter, i) {
  return Card(
      elevation: 20,
      color: item['isBusiness'] == true ? Colors.redAccent : Colors.greenAccent,
      shadowColor: Colors.black38,
      borderOnForeground: true,
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 5, left: 5),
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  formatter
                      .format(new DateTime.fromMicrosecondsSinceEpoch(
                          int.parse(item["createdAt"]) * 1000))
                      .toString(),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            Row(children: <Widget>[
              Container(
                  width: size.width - 40,
                  child: Text(
                    _business["shopName"] == null ? "-" : _business["shopName"],
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.fade,
                  ))
            ]),
            SizedBox(
              height: 10,
            ),
            Row(children: <Widget>[
              Container(
                  width: size.width - 40,
                  child: Text(
                    _business["address"] == null ? "-" : _business["address"],
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.fade,
                  ))
            ]),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Container(
                    width: size.width - 40,
                    child: Text(
                      _user["name"] == null ? "-" : _user["name"],
                      style: TextStyle(fontSize: 20),
                      overflow: TextOverflow.fade,
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Container(
                    width: size.width - 40,
                    child: Text(
                      _user["phone1"],
                      style: TextStyle(fontSize: 20),
                      overflow: TextOverflow.fade,
                    ))
              ],
            ),
          ],
        ),
      ));
}

 avatarImage(String txt){
  print(txt);
   return txt.split(" ").map((e) =>  e.length > 0 ? e.substring(0,1) : "" ).join("").toUpperCase();
//       .split(" ").map((e) => e.substring(0, 1)).join("");
}