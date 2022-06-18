import 'package:flutter/cupertino.dart';

import '../../module/theme.dart';

@immutable
abstract class ThemeState {}

class Initial extends ThemeState {}

class ChangeThemeState extends ThemeState {
  final AppTheme theme;
  ChangeThemeState(this.theme);
}
