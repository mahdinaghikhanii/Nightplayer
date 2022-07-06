import 'package:flutter/material.dart';
import 'package:nightplayer/views/bottom_sheet/playlist_bottomsheet.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../module/constans.dart';
import '../../module/extention.dart';
import '../../module/widgets.dart';
import '../dialog/create_playlist.dart';

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
          } else if (playlistIteam.data!.isEmpty) {
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
                        borderRadius: BorderRadius.circular(
                            Constans.kdefualtBorderRadios)),
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
          return GridView.builder(
              shrinkWrap: true,
              itemCount: playlistIteam.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 210, mainAxisSpacing: 5, crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constans.kdefualtAppPading),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 180,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(30),
                            borderRadius: BorderRadius.circular(
                                Constans.kdefualtBorderRadios)),
                        child: const Center(
                          child: Icon(
                            Icons.favorite,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              playlistIteam.data![index].playlist,
                              style: context.textTheme.subtitle1!
                                  .copyWith(fontSize: 14),
                            ),
                            Text("nightplayer",
                                style: context.textTheme.bodyText1!
                                    .copyWith(color: Colors.grey, fontSize: 12))
                          ],
                        ),
                        const Spacer(),
                        MIconButton(
                            icon: Icons.more_vert,
                            ontap: () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) => PlayListBottomSheet(
                                    playlistModel: playlistIteam.data![index],
                                  ),
                                ))
                      ])
                    ],
                  ),
                );
              });
        },
      )),
    );
  }
}
