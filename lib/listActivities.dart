import 'package:easein/api/caching.dart';
import 'package:easein/api/handlers.dart';
import 'package:easein/components/activityLogList.dart';
import 'package:easein/components/easein_strings.dart';
import 'package:easein/components/easein_theme.dart';
import 'package:easein/model/business.dart';
import 'package:easein/model/user.dart';
import 'package:easein/sidebar.dart';
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
