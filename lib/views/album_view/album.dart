import 'package:flutter/cupertino.dart';
import 'package:nightplayer/module/widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Album extends StatelessWidget {
  final OnAudioQuery audioQuery;

  const Album({Key? key, required this.audioQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder<List<AlbumModel>>(
            future: audioQuery.queryAlbums(
              // sortType: AlbumSortType.ARTIST,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: false,
            ),
            builder: (context, albumdata) {
              if (albumdata.data == null) {
                return const MWating();
              } else if (albumdata.data!.isEmpty) {
                return const MNotFound();
              }

              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 170,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container();
                  });
            }));
  }
}
