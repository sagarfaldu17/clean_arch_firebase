import 'package:flutter/material.dart';

class NavigatorUtil {
  static get(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static getAnRemoveAll(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }
}
