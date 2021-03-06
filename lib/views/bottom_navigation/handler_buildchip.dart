import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../bloc/buildchip_bloc/buildchip_cubit.dart';
import '../../bloc/buildchip_bloc/buildchip_state.dart';
import '../../module/enum.dart';
import '../../module/widgets.dart';
import '../album_view/artist.dart';
import '../album_view/playlist.dart';

class HandlerBuildChip extends StatelessWidget {
  final ScrollController albumContoroller;
  const HandlerBuildChip({Key? key, required this.albumContoroller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnAudioQuery onAudioQuery = OnAudioQuery();
    return BlocBuilder<BuildChipCubit, BuildChipState>(
        builder: (BuildContext context, state) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(state.buildChip == BuildChip.artist
              ? "Artist"
              //  : state.buildChip == BuildChip.album
              //    ? "Album"
              : state.buildChip == BuildChip.playlist
                  ? "PlayList"
                  : ""),
        ),
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 50,
                child: const MBuildChip()),
            const SizedBox(
              height: 20,
            ),
            state.buildChip == BuildChip.artist
                ? Artist(
                    albumContoroller: albumContoroller,
                  )
                : state.buildChip == BuildChip.playlist
                    ? PlayList(
                        audioQuery: onAudioQuery,
                      )
                    : Container()
          ],
        ),
      );
    });
  }
}
