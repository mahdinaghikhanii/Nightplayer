import 'package:flutter/material.dart';
import 'package:nightplayer/views/dialog/create_playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../module/constans.dart';
import '../../module/extention.dart';
import '../../module/widgets.dart';

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
              InkWell(
                onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const DlialogCreatePlayList();
                    }),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius:
                          BorderRadius.circular(Constans.kdefualtBorderRadios)),
                  width: 200,
                  height: 40,
                  child: Center(
                      child: Text("Create yor playlist now !",
                          style: context.textTheme.subtitle1)),
                ),
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
