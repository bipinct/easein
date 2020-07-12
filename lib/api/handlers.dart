import 'dart:convert';

import 'package:easein/api/graphql_handler.dart';
import 'package:easein/listBusiness.dart';
import 'package:easein/model/business.dart';
import 'package:easein/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

getBusinessList() async {
  print("....l is...");
  var businessesLF = await getBusiness();
  List<dynamic> resp = businessesLF != null && businessesLF["list"] != null
      ? businessesLF["list"]
      : null;
print(resp);
  SharedPreferences prefs = await SharedPreferences.getInstance();
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

  prefs.setString("businessList", jsonEncode(fetchedBusinessList));
  return fetchedBusinessList;
}

saveProfileToCache(
    {String email,
    String phone,
    String name,
    String address,
    String aadharNumber,
    String createdAt}) async {
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
        name: _pdata["name"],
        email1: _pdata["email1"],
        phone1: _pdata["phone1"],
        address: _pdata["address"]);
  }
  return _up;
}
