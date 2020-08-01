import 'package:easeinapp/listBusiness.dart';
import 'package:easeinapp/model/business.dart';
import 'package:flutter/material.dart';

class ViewBusiness extends StatefulWidget {
  final Business business;
  ViewBusiness({Key key, @required this.business}) : super(key: key);
  @override
  _ViewBusinessState createState() => _ViewBusinessState();
}

class _ViewBusinessState extends State<ViewBusiness> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: new AppBar(
        title: Text(widget.business.shopName),
        ),
        body:  Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Shop Name",style: TextStyle(fontSize: 14),),
              Text(widget.business.shopName,style: TextStyle(fontSize: 20),),
              SizedBox(height: 20,),
              Text("Address",style: TextStyle(fontSize: 14),),
              Text(widget.business.address,style: TextStyle(fontSize: 20),),
              
            ],
          ),
        ),
      )

     ;
  }
}
