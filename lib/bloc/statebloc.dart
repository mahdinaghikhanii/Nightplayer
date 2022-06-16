import 'package:flutter/cupertino.dart';

import '../module/theme.dart';

@immutable
abstract class StateBloc {}

class ThemeState extends StateBloc {
  final AppTheme theme;
  ThemeState(this.theme);
}

class Loading extends StateBloc {}

class Initial extends StateBloc {}

class Play extends StateBloc {}

class Stop extends StateBloc {}

class Next extends StateBloc {}

class Back extends StateBloc {}

class Failed extends StateBloc {}

class Done extends StateBloc {}

class RequestStoragePermission extends StateBloc {}
