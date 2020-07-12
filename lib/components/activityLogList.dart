import 'package:easein/components/easein_strings.dart';
import 'package:easein/components/empty_state.dart';
import 'package:flutter/material.dart';

List activityLogListBuilder(BuildContext context, activityLogList) {
  return activityLogList.length > 0
      ? activityLogList.map((item) {
          Map<String, dynamic> _user = item["user"];
          Map<String, dynamic> _business = item["business"];
          return Container(
            color: Colors.greenAccent,
            margin: EdgeInsets.only(top: 10, right: 5, left: 5),
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
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
        }).toList()
      : [emptyState(EaseinString.noActivityLogs)];
}
