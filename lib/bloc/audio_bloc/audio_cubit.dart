import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(RequestStoragePermission()) {
    requestStoragePermission();
  }
  final OnAudioQuery _audioQuery = OnAudioQuery();

  nextAudio() async {}

  stopAudio() async {}

  backAudio() async {}

  playAudio() async {}

  void requestStoragePermission() async {
    emit((RequestStoragePermission()));
    //only if the platform is not web, coz web have no permissions
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
    }
  }

  tzTime() {
    if (state is Notifications) {
      print('mahdi');
    }
  }
}
