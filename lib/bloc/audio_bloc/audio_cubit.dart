import 'dart:js';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/module/widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../notification/notification_service.dart';
import 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(RequestStoragePermission()) {
    requestStoragePermission();
  }
  final OnAudioQuery _audioQuery = OnAudioQuery();

  //list for adding all song here
  List<SongModel> allsongmodelList = [];

  bool songIsPlaying = false;

  nextAudio() async {}

  stopAudio() async {}

  backAudio() async {}

  playAudio() async {}

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
      allsongmodelList = allSongsList.toSongModel();
    } catch (e) {
      emit(Failed(e as Exception));
    }
  }

  List<SongModel> mysong = [];
  //only for showing lucall_norification
  //android and ios
  void showMusicNotification(
    String imageSong,
    String artist,
    String nameSong,
    int id,
  ) async {
    emit(Loading());

    songIsPlaying = true;
    try {
      NotificationService().notify(imageSong, artist, nameSong, id);
    } catch (e) {
      emit(Failed(e as Exception));
    }
  }

  void show(SongModel songModel) async {
    try {
      MiniPlayerInBottomNavigation(
        songModel: songModel,
      );
    } catch (e) {}
  }
}
