import 'package:flutter/material.dart';
import 'package:nightplayer/module/constans.dart';

enum AppTheme { dark, light }

final Map<AppTheme, ThemeData> appthemdata = {
  AppTheme.dark: ThemeData(
      textTheme: TextTheme(
          subtitle1:
              TextStyle(color: Constans.kwhite, fontWeight: FontWeight.bold))),
  AppTheme.light: ThemeData(
      textTheme: TextTheme(
          subtitle1:
              TextStyle(color: Constans.kwhite, fontWeight: FontWeight.bold)))
};
