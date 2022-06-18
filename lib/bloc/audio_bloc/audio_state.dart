import 'package:flutter/cupertino.dart';

@immutable
abstract class AudioState {}

class Loading extends AudioState {}

class Initial extends AudioState {}

class Play extends AudioState {}

class Stop extends AudioState {}

class Next extends AudioState {}

class Back extends AudioState {}

class Failed extends AudioState {}

class Done extends AudioState {}

class Notifications extends AudioState {}

class RequestStoragePermission extends AudioState {}
