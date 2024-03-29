// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:nightplayer/model/duration_state.dart';
import 'package:nightplayer/module/extention.dart';
import 'package:nightplayer/module/widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:rxdart/rxdart.dart';

import 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(RequestStoragePermission()) {
    requestStoragePermission();
  }
  final _audioQuery = OnAudioQuery();
  final AudioPlayer player = AudioPlayer();

  //list for adding all song here
  List<SongModel> allSongforSearch = [];

  FToast fToast = FToast();
  // this list just for giving choice user song
  List<SongModel> selectedSongforPLay = <SongModel>[];

  /// list favorite song save local information with Hive
  List<FavoritesEntity> listfavorite = <FavoritesEntity>[];

  //  create an artist model for showing all artists in the song
  List<ArtistModel> artistModel = <ArtistModel>[];

  updateArtistModel(List<ArtistModel> artist) {
    try {
      artistModel.clear();
      artistModel.addAll(artist);
    } catch (e) {
      Failed(e as Exception);
    }
  }

  // all these parts function for saving a favorite list

  addFavoriteAndPushBackScrean(int index, BuildContext context) async {
    final OnAudioRoom audioRoom = OnAudioRoom();
    fToast = FToast();
    fToast.init(context);
    try {
      audioRoom.addTo(RoomType.FAVORITES,
          selectedSongforPLay[index].getMap.toFavoritesEntity(),
          ignoreDuplicate: false);
      audioRoom.getRoomInfo(RoomType.FAVORITES);

      fToast.showToast(
        child: const ToastRemoveOrAdd(index: 0),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
      );
      context.back();
    } catch (e) {
      Failed(e as Exception);
    }
  }

  addFavorite(int index, BuildContext context) async {
    final OnAudioRoom audioRoom = OnAudioRoom();
    fToast = FToast();
    fToast.init(context);
    try {
      audioRoom.addTo(RoomType.FAVORITES,
          selectedSongforPLay[index].getMap.toFavoritesEntity(),
          ignoreDuplicate: false);
      audioRoom.getRoomInfo(RoomType.FAVORITES);

      fToast.showToast(
        child: const ToastRemoveOrAdd(index: 0),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
      );
    } catch (e) {
      Failed(e as Exception);
    }
  }

  updateFavorite(List<FavoritesEntity> audioFavorite) {
    try {
      listfavorite.clear();
      listfavorite.addAll(audioFavorite);
    } catch (e) {
      Failed(e as Exception);
    }
  }

  removeFavorite(
      FavoritesEntity favoritesEntity, int index, BuildContext context) async {
    final OnAudioRoom audioRoom = OnAudioRoom();
    fToast = FToast();
    fToast.init(context);
    try {
      emit(RemoveFavorite());
      await audioRoom.deleteFrom(RoomType.FAVORITES, favoritesEntity.key);
      fToast.showToast(
        child: const ToastRemoveOrAdd(index: 1),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
      );
    } catch (e) {
      Failed(e as Exception);
    }
  }

  /// finishid parts function for add favorites

  // all these parts function for play next stop back a play song
  int index = 0;

  // this index and functions for next audio or back audio

  void setIndex(int i) {
    try {
      index = i;
    } catch (e) {
      Failed(e as Exception);
    }
  }

  // this stream  is for watching time songs

  Stream<DurationState> get durationState =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          player.positionStream,
          player.durationStream,
          (position, duration) => DurationState(
              position: position, duration: duration ?? Duration.zero));

  // backsong
  bool backAudioBool = false;

  updateListSong(List<SongModel> songModel) {
    try {
      selectedSongforPLay.clear();
      selectedSongforPLay.addAll(songModel);
    } catch (e) {
      emit(Failed(e as Exception));
    }
  }

  nextAudio() async {
    int listLenght = selectedSongforPLay.length;
    try {
      songIndex++;
      if (index > listLenght) {
        index;
      } else if (index == listLenght) {
        index;
      } else {
        index++;
      }
      emit(ShowMiniPLayer());
      emit(Next());
      await player.setAudioSource(
        AudioSource.uri(Uri.parse(selectedSongforPLay[index].uri!)),
      );
    } catch (e) {
      Failed(e as Exception);
    }
  }

  void pauseAudio() async {
    emit(Loading());
    try {
      if (player.playing) {
        emit(Pause());
        await player.pause();
      }
    } catch (e) {
      Failed(e as Exception);
    }
  }

  void stopAudio() async {
    try {
      emit(Stop());

      await player.stop();
      player.dispose();
    } catch (e) {
      Failed(e as Exception);
    }
  }

  backAudio() async {
    log("anajm shood");
    log(songIndex.toString());
    try {
      player.seekToPrevious();
      songIndex--;
      if (index > 0) {
        index--;
      }
      emit(Back());
      emit(ShowMiniPLayer());

      emit(Next());

      await player.setAudioSource(AudioSource.uri(
        Uri.parse(
          selectedSongforPLay[index].uri!,
        ),
        tag: MediaItem(
          artUri: Uri.parse(selectedSongforPLay[songIndex].id.toString()),
          // Specify a unique ID for each media item:

          id: songIndex.toString(),
          // Metadata to display in the notification:
          album: selectedSongforPLay[index].album,
          title: selectedSongforPLay[index].title,
        ),
      ));
    } catch (e) {
      Failed(e as Exception);
    }
  }

  randomPlaySong() async {
    try {
      emit(ShowMiniPLayer());
      await player.setLoopMode(LoopMode.all);
      await player.setShuffleModeEnabled(true);
      await player.setAudioSource(
          AudioSource.uri(Uri.parse(selectedSongforPLay[index].uri!)));
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

  int songIndex = 0;

  playAudio(int index) async {
    songIndex = selectedSongforPLay[index].id;

    try {
      emit(Play());
      emit(ShowMiniPLayer());
      await player.setAudioSource(
        AudioSource.uri(
          Uri.parse(
            selectedSongforPLay[index].uri!,
          ),
          tag: MediaItem(
            // Specify a unique ID for each media item:
            id: songIndex.toString(),
            // Metadata to display in the notification:
            album: selectedSongforPLay[index].album,
            title: selectedSongforPLay[index].title,
          ),
        ),
      );

      player.setLoopMode(LoopMode.one);
      await player.play();
    } catch (e) {
      emit(Failed(e as Exception));
    }
  }

  void requestStoragePermission() async {
    //only if the platform is not web, coz web have no permissions
    emit((RequestStoragePermission()));
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
    }
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
  /* void showMusicNotification(
      String imageSong, String artist, String nameSong, int id) async {
    try {
      emit(ShowMiniPLayer());

      NotificationService().notify(imageSong, artist, nameSong, id);
    } catch (e) {
      emit(Failed(e as Exception));
    }
  }*/

  ///show Toast add favorite or remove favorite
  //
  showToast() {
    FToast().showToast(
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
        child: const ToastRemoveOrAdd(index: 0));
  }
}
