import 'package:easein/components/easein_strings.dart';
import 'package:easein/components/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List activityLogListBuilder(BuildContext context, activityLogList) {
  Size size = MediaQuery.of(context).size;
  final DateFormat formatter = DateFormat('dd MMMM h:mm a ');
  return activityLogList.length > 0
      ? activityLogList.map((item) {
          Map<String, dynamic> _user = item["user"];
          Map<String, dynamic> _business = item["business"];
          return Card(
              elevation: 20,
              shadowColor: Colors.black38,
              borderOnForeground: true,
              child: Container(
                margin: EdgeInsets.only(top: 10, right: 5, left: 5),
                padding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
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
                            _business["shopName"] == null
                                ? "-"
                                : _business["shopName"],
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
                            _business["address"] == null
                                ? "-"
                                : _business["address"],
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
        }).toList()
      : [emptyState(EaseinString.noActivityLogs)];
}
