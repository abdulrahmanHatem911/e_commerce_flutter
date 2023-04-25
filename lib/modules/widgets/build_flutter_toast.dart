import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showFlutterToast({required String message, required Color toastColor}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: toastColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
