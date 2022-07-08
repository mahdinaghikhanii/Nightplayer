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

  nextAudio() async {}

  pauseAudio() async {
    await player.pause();
  }

  stopAudio() async {
    await player.stop();
  }

  backAudio() async {}

  playAudio(SongModel songModel) async {
    emit(Play());
    await player.setUrl(songModel.uri.toString());
    await player.play();
    player.setLoopMode(LoopMode.one);
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
    String imageSong,
    String artist,
    String nameSong,
    int id,
  ) async {
    emit(Loading());

    try {
      NotificationService().notify(imageSong, artist, nameSong, id);
    } catch (e) {
      emit(Failed(e as Exception));
    }
  }
}
