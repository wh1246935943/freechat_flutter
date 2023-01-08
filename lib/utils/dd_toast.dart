import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DDToast {

  static void success(String msg) {
    _showToast(msg, const Color.fromRGBO(35, 121, 4, 1));
  }

  static void error(String msg) {
    _showToast(msg, Colors.red);
  }

  static void info(String msg) {
    _showToast(msg, const Color.fromARGB(255, 67, 67, 67));
  }

  static void warn(String msg) {
    _showToast(msg, Colors.yellow);
  }

  static void _showToast(String msg, Color color) {
    Fluttertoast.cancel();
    
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.TOP,
      backgroundColor: color,
      timeInSecForIosWeb: _getTime(msg),
    );
  }

  static int _getTime(String msg) {
    double multiplier = 0.5;
    double flag = msg.length * 0.06 + 0.5;
    return (multiplier * flag).round();
  }
  
}