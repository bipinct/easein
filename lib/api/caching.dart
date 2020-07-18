import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

loadActivityFromCache() async{
  var _decodeActivity;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var activityFromCache = prefs.getString("activitylog");
  if(activityFromCache != null){
     _decodeActivity = jsonDecode(activityFromCache);
  }
  return _decodeActivity;
}

saveActivityLogToCache(data)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("activitylog", jsonEncode(data));
}
//
//setState(() {

//});