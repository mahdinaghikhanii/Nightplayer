import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'bloc/audiobloc.dart';
import 'bloc/navbarbloc.dart';
import 'bloc/statebloc.dart';
import 'bloc/themebloc.dart';
import 'module/theme.dart';
import 'views/home.dart';

void main() {
  OnAudioQuery();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
    BlocProvider<AudioBloc>(create: (_) => AudioBloc()),
    BlocProvider<NavbarBloc>(create: (_) => NavbarBloc())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, StateBloc>(
      builder: (_, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Nightplayer',
            theme:
                appthemdata[state is ThemeState ? state.theme : AppTheme.light],
            home: BlocBuilder<AudioBloc, StateBloc>(builder: (_, state) {
              state is RequestStoragePermission;
              return Home(
                stateBloc: state,
              );
            }));
      },
    );
  }
}
