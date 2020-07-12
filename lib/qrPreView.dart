import 'package:easein/model/business.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

Widget qrPreview(BuildContext context, Business business) {
  Size size = MediaQuery.of(context).size;
  return business != null
      ? Column(
          children: <Widget>[
            QrImage(
              data: business.qrcodeString,
              version: QrVersions.auto,
              size: size.width,
            ),
            Text(business.shopName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text(business.address),
          ],
        )
      : Wrap();
}
