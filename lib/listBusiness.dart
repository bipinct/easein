import 'package:easein/api/graphql_handler.dart';
import 'package:flutter/material.dart';

class ListBusiness extends StatefulWidget {
  @override
  _ListBusinessState createState() => _ListBusinessState();
}

class _ListBusinessState extends State<ListBusiness> {
  List<Business> businessList = [];
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loading = true;
    });
    getBusinessList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        backgroundColor: Color(0xFF5c00d2),
        appBar: new AppBar(
        title: Text("My Businesses"),
    ),
    body: Stack(children: <Widget>[
      ListView(
        children: <Widget>[
          ListTile(
            title: Text("businessnea"),
            subtitle: Text("abbbasdsadsad"),
          ),
          Divider(),
          ListTile(
            title: Text("businessnea"),
            subtitle: Text("abbbasdsadsad"),
          )
        ],
      )
    ]));
  }

  getBusinessList () async{
    var businesses =  await getBusiness();
    print("*********************");
    print("*********************");
    print("*********************");
    print(businesses);
  }
}

class Business {
  final String shopName;
  final String about;
  final String phone;
  final String profilepic;
  final String email;
  final String address;


  Business({
    this.shopName,
    this.about,
    this.phone,
    this.email,
    this.address,
    this.profilepic
  });
}