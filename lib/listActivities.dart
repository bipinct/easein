import 'package:easeinapp/api/caching.dart';
import 'package:easeinapp/api/handlers.dart';
import 'package:easeinapp/components/activityLogList.dart';
import 'package:easeinapp/components/easein_strings.dart';
import 'package:easeinapp/components/easein_theme.dart';
import 'package:easeinapp/model/business.dart';
import 'package:easeinapp/model/user.dart';
import 'package:easeinapp/sidebar.dart';
import 'package:flutter/material.dart';

class ListActivities extends StatefulWidget {
  @override
  _ListActivitiesState createState() => _ListActivitiesState();
}

class _ListActivitiesState extends State<ListActivities> {
  bool loading = false;
  List<dynamic> allActivityLogList = [];
  User userProfile;

  @override
  void initState() {
    super.initState();
    cachedActivity();
    loadActivity();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text(EaseinString.appName),
        ),
        body: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.only(top: 10),
              children: <Widget>[
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
                ...activityLogListBuilder(context, allActivityLogList)
              ],
            ),

          ],
        )
      );
  }

  cachedActivity() async {
    if(mounted) {
      var _cha = await loadActivityFromCache();
      setState(() {
        allActivityLogList = _cha;
      });
    }
  }

  loadActivity() async {
    if(mounted) {
      var _loadFromApi = await loadActivityLogFromApi();
      setState(() {
        loading = false;
        allActivityLogList = _loadFromApi;
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}
