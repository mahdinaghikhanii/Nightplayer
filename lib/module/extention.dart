import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  void nextPage(Widget child) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => child));
  }

  void back() {
    Navigator.pop(this);
  }
}
