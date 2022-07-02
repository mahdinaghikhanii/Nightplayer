import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/bloc/playlist_bloc/playlist_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(LoadingPlayList());

  final OnAudioQuery _audioQuery = OnAudioQuery();

  someName() async {
    // DEFAULT:
    // PlaylistSortType.NAME,
    // OrderType.ASC_OR_SMALLER
    List<PlaylistModel> something = await _audioQuery.queryPlaylists();
  }
}
