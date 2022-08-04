import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../module/constans.dart';
import '../module/extention.dart';

class DetailArtist extends StatelessWidget {
  final AlbumModel albumModel;

  const DetailArtist({Key? key, required this.albumModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constans.kdefualtAppPading),
            child: IconButton(
                onPressed: (() => context.back()),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: Constans.kdefualtSizeIcon,
                )),
          ),
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              background: QueryArtworkWidget(
                  artworkBorder: BorderRadius.circular(0),
                  id: albumModel.id,
                  type: ArtworkType.ALBUM),
              centerTitle: false,
              title: Text(albumModel.album.toString())),
          pinned: true,
          expandedHeight: 350,
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return GestureDetector(
            //      onTap: () => context.nextPage(PlayOrStopSong(songModel: albumModel[index],)),
            child: Column(
              children: [
                ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: Constans.kdefualtAppPading),
                    subtitle: Text(albumModel.album.toString()),
                    leading: QueryArtworkWidget(
                        nullArtworkWidget: Image.asset(
                          'assets/img/null.jpg',
                          width: 65,
                          height: 65,
                          fit: BoxFit.fill,
                        ),
                        artworkBorder: BorderRadius.circular(10),
                        artworkWidth: 60,
                        artworkHeight: 60,
                        id: albumModel.id,
                        type: ArtworkType.ALBUM),
                    textColor: Colors.white,
                    title: Text(albumModel.artist.toString())),
              ],
            ),
          );
        }, childCount: albumModel.numOfSongs))
      ],
    ));
  }
}
