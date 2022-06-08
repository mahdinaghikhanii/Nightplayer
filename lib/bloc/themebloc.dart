import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/bloc/statebloc.dart';

class ThemeBloc extends Cubit<StateBloc> {
  ThemeBloc() : super(Initial());

  void setTheme() {}

  void getTheme() {}
}
