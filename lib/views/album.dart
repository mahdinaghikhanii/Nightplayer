import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../module/constans.dart';
import '../module/extention.dart';
import '../module/widgets.dart';

class Album extends StatelessWidget {
  const Album({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _rrectController = ScrollController();
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
            'Artists',
            style: context.textTheme.subtitle1!.copyWith(fontSize: 22),
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 50,
              child: const MBuildChip()),
          const SizedBox(height: 20),
          Expanded(
              child: FutureBuilder<List<ArtistModel>>(
                  future: audioQuery.queryArtists(
                    // sortType: AlbumSortType.ARTIST,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: false,
                  ),
                  builder: (context, iteamAlbum) {
                    if (iteamAlbum.data == null) {
                      return const MWating();
                    }
                    return DraggableScrollbar.rrect(
                      controller: _rrectController,
                      child: GridView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constans.kdefualtAppPading),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 170,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return InkWell(
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
                                      id: iteamAlbum.data![index].id,
                                      type: ArtworkType.ARTIST),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    iteamAlbum.data![index].artist,
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.subtitle1!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  })),
        ],
      ),
    );
  }
}
