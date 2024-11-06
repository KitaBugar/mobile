import 'package:flutter/material.dart';

class NavigationHelper {
  static void nextScreen(BuildContext context, Widget widget) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget),
      );
}
