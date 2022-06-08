import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/bloc/audiobloc.dart';
import 'package:nightplayer/bloc/statebloc.dart';
import 'package:nightplayer/bloc/themebloc.dart';
import 'package:nightplayer/module/constans.dart';
import 'package:nightplayer/module/theme.dart';
import 'package:nightplayer/views/home.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
    BlocProvider<AudioBloc>(create: (_) => AudioBloc())
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
              return Home(
                stateBloc: state,
              );
            }));
      },
    );
  }
}
