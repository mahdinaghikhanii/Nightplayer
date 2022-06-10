import 'package:flutter/material.dart';
import 'package:nightplayer/module/constans.dart';

enum AppTheme { dark, light }

final Map<AppTheme, ThemeData> appthemdata = {
  AppTheme.dark: ThemeData(
      scaffoldBackgroundColor: Constans.kdefultAppColor,
      appBarTheme: AppBarTheme(backgroundColor: Constans.kdefultAppColor),
      textTheme: TextTheme(
          subtitle1: TextStyle(
        color: Constans.kwhite,
        fontWeight: FontWeight.bold,
      ))),
  AppTheme.light: ThemeData(
      scaffoldBackgroundColor: Constans.kdefultAppColor,
      appBarTheme: AppBarTheme(
          backgroundColor: Constans.kdefultAppColor,
          toolbarTextStyle: TextTheme(
              subtitle1: TextStyle(
            color: Constans.kwhite,
            fontWeight: FontWeight.bold,
          )).bodyText2,
          titleTextStyle: TextTheme(
              subtitle1: TextStyle(
            color: Constans.kwhite,
            fontWeight: FontWeight.bold,
          )).headline6))
};
