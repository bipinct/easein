import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

errorAlert(BuildContext context, int errorType) {
  String title = "Error";
  String message =
      "Error Connecting server. Please check your internet connection";
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
  }
  return Alert(context: context, title: title, desc: message).show();
}
