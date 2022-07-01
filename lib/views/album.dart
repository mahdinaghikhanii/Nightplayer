import 'package:flutter/material.dart';
import 'package:nightplayer/views/detail_album.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../module/constans.dart';
import '../module/extention.dart';
import '../module/widgets.dart';

class Album extends StatelessWidget {
  const Album({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OnAudioQuery audioQuery = OnAudioQuery();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constans.kdefultAppColor,
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constans.kdefualtAppPading),
          child: Text(
            'Album',
            style: context.textTheme.subtitle1!.copyWith(fontSize: 22),
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<List<AlbumModel>>(
                  future: audioQuery.queryAlbums(
                    sortType: AlbumSortType.ALBUM,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: false,
                  ),
                  builder: (context, iteamAlbum) {
                    if (iteamAlbum.data == null) {
                      return const MWating();
                    }
                    return GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constans.kdefualtAppPading),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 170,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => context.nextPage(DetailAlbum(
                              albumModel: iteamAlbum.data![index],
                            )),
                            child: Column(
                              children: [
                                QueryArtworkWidget(
                                    nullArtworkWidget: Image.asset(
                                      'assets/icon/song248.png',
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.fill,
                                    ),
                                    artworkWidth: 100,
                                    artworkHeight: 100,
                                    id: iteamAlbum.data![index].id,
                                    type: ArtworkType.ALBUM),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  iteamAlbum.data![index].album,
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.subtitle1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  iteamAlbum.data![index].artist.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.subtitle1,
                                )
                              ],
                            ),
                          );
                        });
                  })),
        ],
      ),
    );
  }
}
