import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nightplayer/module/constans.dart';
import 'package:nightplayer/module/extention.dart';
import 'package:nightplayer/module/widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayList extends StatelessWidget {
  final OnAudioQuery audioQuery;
  const PlayList({Key? key, required this.audioQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
            child: FutureBuilder<List<PlaylistModel>>(
      future: audioQuery.queryPlaylists(),
      builder: (context, playlistIteam) {
        if (playlistIteam.data == null) {
          return const MWating();
        } else if (playlistIteam.data!.isNotEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MNotFound(
                text: "Not found any PlayList !",
                fontsize: 16,
                imgSize: 200,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius:
                        BorderRadius.circular(Constans.kdefualtBorderRadios)),
                width: 200,
                height: 40,
                child: Center(
                    child: Text("Create yor playlist now !",
                        style: context.textTheme.subtitle1)),
              )
            ],
          );
        }
        return ListView.builder(itemBuilder: (BuildContext context, int index) {
          return Container();
        });
      },
    )));
  }
}
