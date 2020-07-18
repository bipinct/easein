import 'package:easein/components/error_alerts.dart';
import 'package:flutter/material.dart';

errorHandler(BuildContext context,String error){
  int errorType = 0;
  if (error.indexOf("Failed host lookup") != -1) {
    errorType = 1;
  } else if (error.indexOf("Cannot return null for non-nullable field") !=  -1) {
    errorType = 2;
  }
  errorAlert(context, errorType);
}