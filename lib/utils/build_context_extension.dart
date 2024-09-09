import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void navigateToScreen(Widget screen, {bool isReplace = false}) {
    if (isReplace) {
      Navigator.of(this).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => screen,
          ),
          (route) => false);
    } else {
      Navigator.of(this).push(MaterialPageRoute(
        builder: (_) => screen,
      ));
    }
  }

  double getHeight(double percentage) {
    return MediaQuery.of(this).size.height * percentage;
  }
  double getWidth(double percentage) {
    return MediaQuery.of(this).size.width * percentage;
  }
}
