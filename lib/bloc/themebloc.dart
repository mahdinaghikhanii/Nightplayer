// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/bloc/statebloc.dart';
import 'package:nightplayer/module/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Cubit<ThemeState> {
  ThemeBloc() : super(ThemeState(AppTheme.dark)) {
    loadTheme();
  }

  void loadTheme() async {
    SharedPreferences _prfs = await SharedPreferences.getInstance();
    String _str = _prfs.getString('theme') ?? '';

    if (_str == 'dark') emit(ThemeState(AppTheme.dark));
  }

  void setTheme(AppTheme theme) async {
    emit(ThemeState(theme));

    await SharedPreferences.getInstance().then((value) =>
        value.setString('theme', theme == AppTheme.dark ? 'dark' : 'light'));
  }
}
