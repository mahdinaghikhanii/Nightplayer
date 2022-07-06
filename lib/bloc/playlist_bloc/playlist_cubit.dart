import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'playlist_state.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(LoadingPlayList());
  final OnAudioQuery _audioQuery = OnAudioQuery();

  void createPlayList(String namePlayList, context) async {
    emit(LoadingPlayList());
    try {
      await _audioQuery.createPlaylist(namePlayList.toString());
      Navigator.pop(context, true);

      emit(CreatePlayList());
    } catch (e) {
      log(e.toString());
      FailCreatePlayList(e as Exception);
    }
  }

  void editNamePlaylist(int playListId, String edit, context) async {
    try {
      emit(EditPlayList());
      await _audioQuery.renamePlaylist(playListId, edit.toString());
      Navigator.pop(context, true);
    } catch (e) {
      FailCreatePlayList(e as Exception);
    }
  }

  deletePlayList(int idPlayList) async {
    emit(LoadingPlayList());
    try {
      await _audioQuery.removePlaylist(idPlayList);
    } catch (e) {
      // print(e.toString());
      FailCreatePlayList(e as Exception);
    }
  }

  addSongPlayList(int idPlayList, int audioId) async {
    try {
      await _audioQuery.addToPlaylist(idPlayList, audioId);
    } catch (e) {
      FailCreatePlayList(e as Exception);
    }
  }
}
