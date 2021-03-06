import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/bloc/playlist_bloc/playlist_cubit.dart';

import '../bloc/audio_bloc/audio_cubit.dart';

extension ContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  void nextPage(Widget child) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => child));
  }

  void back() {
    Navigator.pop(this);
  }

  AudioCubit get audioCuibt => read<AudioCubit>();
  PlayListCubit get playListCubit => read<PlayListCubit>();
}
