import 'package:flutter/material.dart';

@immutable
abstract class PlayListState {}

class CreatePlayList extends PlayListState {}

class DeletePlayList extends PlayListState {}

class GetPlayList extends PlayListState {}

class LoadingPlayList extends PlayListState {}
