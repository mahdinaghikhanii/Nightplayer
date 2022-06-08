import 'package:flutter/cupertino.dart';

@immutable
abstract class BlocState {}

class Loading extends BlocState {}

class Play extends BlocState {}

class Stop extends BlocState {}

class Next extends BlocState {}

class Back extends BlocState {}

class Failed extends BlocState {}

class Done extends BlocState {}
