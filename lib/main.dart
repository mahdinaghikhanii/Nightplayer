import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/views/onboard.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/audio_bloc/audio_cubit.dart';
import 'bloc/btnnavigation_bloc/btmnavigation_cubit.dart';
import 'bloc/buildchip_bloc/buildchip_cubit.dart';
import 'bloc/onboard_bloc/onboard_cubit.dart';
import 'bloc/playlist_bloc/playlist_cubit.dart';
import 'bloc/theme_bloc/theme_state.dart';
import 'bloc/theme_bloc/themebloc.dart';
import 'module/theme.dart';
import 'views/home.dart';

int? isviewed;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  isviewed = preferences.getInt("InBoardScreans");
  await OnAudioRoom().initRoom(RoomType.FAVORITES);
  // await OnAudioRoom().initRoom(RoomType.PLAYLIST);

  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'music_group',
            channelKey: 'music_chanel',
            channelName: 'nightplayer',
            channelDescription: 'play onsg',
            defaultColor: Colors.red,
            //   importance: NotificationImportance.High,
            playSound: false,
            channelShowBadge: false,
            enableVibration: false,
            enableLights: false,
            defaultPrivacy: NotificationPrivacy.Public,
            locked: true,
            ledColor: Colors.white),
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'basic_channel'),
      ],
      debug: true);

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (_, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Nightplayer',
            theme: appthemdata[
                state is ChangeThemeState ? state.theme : AppTheme.light],
            home: isviewed != 0 ? const OnBoard() : const Home());
      },
    );
  }
}
