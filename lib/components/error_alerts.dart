import 'package:easeinapp/components/easein_strings.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

errorAlert(BuildContext context, int errorType,String errorMessage) {
  String title = "Error";
  String message =
      "Error Connecting server. Please check your internet connection";
  if(errorMessage != null)
    return Alert(context: context, title: title, desc: errorMessage).show();
  switch (errorType) {
    case 0:
      message = "Error in request! Try again";
      break;
    case 1:
      break;
    case 2:
      message = "Invalid OTP";
      break;
    case 4:
      message = "Error updating profile";
      break;
    case 5:
      message = "Invalid QR code";
      break;
    case 6:
      message = "Invalid Phone Number";
      break;
    case 7:
      message = "Error Login please contact "+ EaseinString.customerSupportNumber ;
      break;
    case 8:
      message = "Please enter OTP";
      break;
    case 10:
      message = "Error connecting server. check your network connection";
      break;

  }
  return Alert(context: context, title: title, desc: message).show();
}
