import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:nightplayer/views/detail_artist.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../module/constans.dart';
import '../../module/extention.dart';
import '../../module/widgets.dart';

class Artist extends StatelessWidget {
  final ScrollController albumContoroller;
  const Artist({Key? key, required this.albumContoroller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OnAudioQuery audioQuery = OnAudioQuery();
    return Expanded(
        child: FutureBuilder<List<ArtistModel>>(
            future: audioQuery.queryArtists(
              // sortType: AlbumSortType.ARTIST,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,

              ignoreCase: false,
            ),
            builder: (context, iteamArtist) {
              if (iteamArtist.data == null) {
                return const MWating();
              }
              if (iteamArtist.data!.isEmpty) {
                return const MNotFound();
              }
              context.audioCuibt.updateArtistModel(iteamArtist.data!);
              var artistData = context.audioCuibt.artistModel;
              return DraggableScrollbar.rrect(
                controller: albumContoroller,
                child: GridView.builder(
                    controller: albumContoroller,
                    itemCount: artistData.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constans.kdefualtAppPading),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 170,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (() => context.nextPage(
                            DetailArtist(artistModel: artistData[index]))),
                        borderRadius: BorderRadius.circular(
                            Constans.kdefualtBorderRadios),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QueryArtworkWidget(
                                nullArtworkWidget: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: Image.asset(
                                    'assets/img/null.jpg',
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                artworkBorder: BorderRadius.circular(100),
                                artworkWidth: 130,
                                artworkHeight: 130,
                                id: artistData[index].id,
                                type: ArtworkType.ARTIST),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              artistData[index].artist,
                              textAlign: TextAlign.center,
                              style: context.textTheme.subtitle1!,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    }),
              );
            }));
  }
}
