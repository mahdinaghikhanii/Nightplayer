// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/bloc/theme_bloc/theme_state.dart';
import 'package:nightplayer/module/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ChangeThemeState(AppTheme.dark)) {
    loadTheme();
  }

  void loadTheme() async {
    SharedPreferences _prfs = await SharedPreferences.getInstance();
    String _str = _prfs.getString('theme') ?? '';

    if (_str == 'dark') emit(ChangeThemeState(AppTheme.dark));
  }

  void setTheme(AppTheme theme) async {
    emit(ChangeThemeState(theme));

    await SharedPreferences.getInstance().then((value) =>
        value.setString('theme', theme == AppTheme.dark ? 'dark' : 'light'));
  }
}
