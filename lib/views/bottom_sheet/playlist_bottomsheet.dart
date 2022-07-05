import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../module/constans.dart';
import '../../module/extention.dart';
import '../../module/widgets.dart';
import '../dialog/create_playlist.dart';

class PlayListBottomSheet extends StatelessWidget {
  final PlaylistModel playlistModel;
  const PlayListBottomSheet({Key? key, required this.playlistModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: 260,
      decoration: BoxDecoration(
          color: Constans.kdefultAppColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            playlistModel.playlist,
            style: context.textTheme.subtitle1,
          ),
          const SizedBox(height: 20),
          MListTileForBottomSheet(
            icon: Icons.delete,
            iconColor: Colors.white,
            text: "Delete playlist",
            textStyle: context.textTheme.subtitle1,
            ontap: () {
              context.playListCubit.deletePlayList(playlistModel.id);
              context.back();
            },
          ),
          MListTileForBottomSheet(
            icon: CupertinoIcons.music_albums,
            iconColor: Colors.white,
            text: "Create playlist",
            textStyle: context.textTheme.subtitle1,
            ontap: () {
              context.back();
              showDialog(
                  context: context,
                  builder: (context) => const DlialogCreatePlayList());
            },
          ),
        ],
      ),
    );
  }
}
