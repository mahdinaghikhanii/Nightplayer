import 'package:flutter/cupertino.dart';

@immutable
abstract class AudioState {}

class Loading extends AudioState {}

class Initial extends AudioState {}

class Play extends AudioState {}

class Stop extends AudioState {}

class Pause extends AudioState {}

class Next extends AudioState {}

class Back extends AudioState {}

class Failed extends AudioState {
  final Exception exception;
  Failed(this.exception);
}

class RemoveFavorite extends AudioState {}

class Favorite extends AudioState {}

class Done extends AudioState {}

class ShowNotifications extends AudioState {}

class ShowMiniPLayer extends AudioState {}

class AnimationMiniPLayer extends AudioState {}

class RequestStoragePermission extends AudioState {}
