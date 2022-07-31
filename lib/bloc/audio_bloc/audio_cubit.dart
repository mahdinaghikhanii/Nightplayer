import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../notification/notification_service.dart';
import 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(RequestStoragePermission()) {
    requestStoragePermission();
  }
  final _audioQuery = OnAudioQuery();
  final player = AudioPlayer();

  //list for adding all song here
  List<SongModel> allSongforSearch = [];

  // this list just for giving choice user song
  List<SongModel> selectedSongforPLay = [];

  addData(SongModel songModel) {
    try {
      selectedSongforPLay.clear();
      selectedSongforPLay.add(songModel);
    } catch (e) {
      emit(Failed(e as Exception));
    }
  }

  nextAudio() async {
    try {
      await player.seekToNext();
    } catch (e) {
      Failed(e as Exception);
    }
  }

  void pauseAudio() async {
    emit(Loading());
    try {
      emit(Pause());
      await player.pause();
    } catch (e) {
      Failed(e as Exception);
    }
  }

  String formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format =
        "${(minute < 10) ? "0$minute" : "$minute"}:${(second < 10) ? "0$second" : "$second"}";
    return format;
  }

  void stopAudio() async {
    try {
      emit(Stop());
      await player.stop();
    } catch (e) {
      Failed(e as Exception);
    }
  }

  backAudio() async {
    try {
      await player.seekToPrevious();
    } catch (e) {
      Failed(e as Exception);
    }
  }

  resumeSong() async {
    try {
      emit(Play());
      emit(ShowMiniPLayer());
      await player.play();
      player.setLoopMode(LoopMode.one);
    } catch (e) {
      emit(Failed(e as Exception));
    }
  }

  playAudio(SongModel songModel) async {
    try {
      emit(Play());
      await player.setUrl(songModel.uri.toString());
      await player.play();
      player.setLoopMode(LoopMode.one);
    } catch (e) {
      emit(Failed(e as Exception));
    }
  }

  void requestStoragePermission() async {
    //only if the platform is not web, coz web have no permissions
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
    }
    emit((RequestStoragePermission()));
  }

  // using for search artist name and find your song
  void searchInListforFindArtist(String query) async {
    try {
      List<dynamic> allSongsList = await _audioQuery.queryWithFilters(
        query,
        WithFiltersType.AUDIOS,
        args: AudiosArgs.TITLE,
      );
      allSongforSearch = allSongsList.toSongModel();
    } catch (e) {
      emit(Failed(e as Exception));
    }
  }

  //only for showing lucall_norification
  //android and ios
  void showMusicNotification(
      String imageSong, String artist, String nameSong, int id) async {
    try {
      emit(ShowMiniPLayer());

      NotificationService().notify(imageSong, artist, nameSong, id);
    } catch (e) {
      emit(Failed(e as Exception));
    }
  }
}
