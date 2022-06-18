import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'bloc/audio_bloc/audio_cubit.dart';
import 'bloc/audio_bloc/audio_state.dart';
import 'bloc/theme_bloc/theme_state.dart';
import 'bloc/theme_bloc/themebloc.dart';
import 'module/theme.dart';
import 'notification/notification_service.dart';
import 'views/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  OnAudioQuery();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
    BlocProvider<AudioCubit>(create: (_) => AudioCubit()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (_, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Nightplayer',
            theme: appthemdata[
                state is ChangeThemeState ? state.theme : AppTheme.light],
            home: BlocBuilder<AudioCubit, AudioState>(builder: (_, state) {
              state is RequestStoragePermission;
              return Home(
                stateaudio: state,
              );
            }));
      },
    );
  }
}
