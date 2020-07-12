import 'dart:convert';

import 'package:easein/model/business.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget businessListForQuickNavigation(BuildContext buildContext,
    List<Business> businessQR, updatetostate, selectedBusinessForQRView) {
  MainAxisAlignment talign = businessQR.length > 2
      ? MainAxisAlignment.spaceAround
      : MainAxisAlignment.end;

  int biznum = 1;
  return businessQR.length > 0
      ? Container(
          color: Colors.lime,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: talign,
            children: <Widget>[
              ...businessQR.map((Business bis) => Material(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue,
                    child: InkWell(
                      splashColor: selectedBusinessForQRView != null &&
                              selectedBusinessForQRView.isSelected != null &&
                              selectedBusinessForQRView.isSelected == true
                          ? Colors.redAccent
                          : Colors.blue[900],
                      child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: Text(
                              (biznum++).toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        businessQR.map((e) {
                          if (selectedBusinessForQRView == null) {
                            e.isSelected = false;
                          } else {
                            if (e.shopName ==
                                selectedBusinessForQRView.shopName) {
                              e.isSelected = true;
                            }
                          }
                          return e;
                        });

                        if (selectedBusinessForQRView != null &&
                            selectedBusinessForQRView.shopName == bis.shopName)
                          selectedBusinessForQRView = null;
                        else
                          selectedBusinessForQRView = bis;
                        updatetostate(selectedBusinessForQRView);

                        prefs.setString("businessList", jsonEncode(businessQR));
                      }, // or use onPressed: () {}
                    ),
                  ))
            ],
          ),
        )
      : Wrap();
}
