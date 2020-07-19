import 'dart:convert';

import 'package:easein/api/caching.dart';
import 'package:easein/api/graphql_handler.dart';
import 'package:easein/model/business.dart';
import 'package:easein/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

getBusinessList() async {
  var businessesLF = await getBusiness();
  List<dynamic> resp = businessesLF != null && businessesLF["list"] != null
      ? businessesLF["list"]
      : null;

  List<Business> fetchedBusinessList = [];
  var bizLis = [];
  for (var i = 0; i < businessesLF["list"].length; i++) {
    Business biz = Business(
        address: businessesLF["list"][i]["address"],
        shopName: businessesLF["list"][i]["shopName"],
        createdAt: businessesLF["list"][i]["createdAt"],
        publicid: businessesLF["list"][i]["publicid"],
        qrcodeString: businessesLF["list"][i]["qrcodeString"],
        isSelected: false);
    fetchedBusinessList.add(biz);
  }
  saveBusinessToCache(fetchedBusinessList);
  return fetchedBusinessList;
}

saveBusinessToCache(businessList) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("businessList", jsonEncode(businessList));
}

saveProfileToCache({String email, String phone, String name,String address, String aadharNumber, String createdAt}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User _user = new User(
      email1: email,
      phone1: phone,
      name: name,
      address: address,
      createdAt: createdAt);
  prefs.setString("profile", jsonEncode(_user));
}

Future<User> getProfile() async {
  User _up;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String profile = prefs.getString("profile");
  if (profile != null) {
    var _pdata = jsonDecode(profile);
    _up = new User(
        createdAt: _pdata["createdAt"],
        name: _pdata["name"] != null  ? _pdata["name"]  : "NA",
        email1: _pdata["email1"] != null ? _pdata["email1"] : "NA",
        phone1: _pdata["phone1"],
        address: _pdata["address"] != null ? _pdata["address"] : "NA");
  }
  return _up;
}

avatarImage(String txt) {
  var spl = txt.trim().split(" ");
  var     _chr = spl[0].substring(0,1);
  if(spl.length > 1){
    _chr = _chr + spl[spl.length - 1].trim().substring(0,1);
  }
  return _chr.toUpperCase();
}

loadActivityLogFromApi() async {
  var activities = await getActivityLog();
  List<dynamic> resp = activities != null && activities["list"] != null
      ? activities["list"]
      : null;
  saveActivityLogToCache(activities["list"]);
  return activities["list"];
}