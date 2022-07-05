import 'package:flutter/material.dart';

@immutable
abstract class PlayListState {}

class CreatePlayList extends PlayListState {}

class FailCreatePlayList extends PlayListState {
  final Exception exception;
  FailCreatePlayList(this.exception);
}

class DeletePlayList extends PlayListState {}

class EditPlayList extends PlayListState {}

class GetPlayList extends PlayListState {}

class LoadingPlayList extends PlayListState {}
