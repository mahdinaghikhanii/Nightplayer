import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/bloc/playlist_bloc/playlist_state.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(LoadingPlayList());
}
