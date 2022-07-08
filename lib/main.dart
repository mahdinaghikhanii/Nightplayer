import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/views/onboard.dart';

import 'package:on_audio_query/on_audio_query.dart';

import 'bloc/audio_bloc/audio_cubit.dart';
import 'bloc/audio_bloc/audio_state.dart';
import 'bloc/btnnavigation_bloc/btmnavigation_cubit.dart';
import 'bloc/buildchip_bloc/buildchip_cubit.dart';
import 'bloc/onboard_bloc/onboard_cubit.dart';
import 'bloc/onboard_bloc/onboard_state.dart';
import 'bloc/playlist_bloc/playlist_cubit.dart';
import 'bloc/theme_bloc/theme_state.dart';
import 'bloc/theme_bloc/themebloc.dart';
import 'module/theme.dart';
import 'views/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'nightplayer',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Colors.white,
            playSound: true,
            channelShowBadge: false,
            enableVibration: true,
            enableLights: true,
            ledColor: Colors.white),
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'basic_channel'),
      ],
      debug: true);
  //zNotificationService().initNotification();

  OnAudioQuery();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
    BlocProvider(create: (_) => BuildChipCubit()),
    BlocProvider<AudioCubit>(create: (_) => AudioCubit()),
    BlocProvider<BtmNavigationCubit>(create: (_) => BtmNavigationCubit()),
    BlocProvider<PlayListCubit>(create: (_) => PlayListCubit()),
    BlocProvider(create: (_) => OnBoardCubit())
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
            home: BlocBuilder<OnBoardCubit, OnboardState>(
              builder: (BuildContext context, state) {
                return BlocBuilder<AudioCubit, AudioState>(
                    builder: (_, stateAudio) {
                  if (state is RequestStoragePermission || state is OnBoards) {
                    return Home(stateaudio: stateAudio);
                  }
                  return OnBoard(stateaudio: stateAudio);
                });
              },
            ));
      },
    );
  }
}
