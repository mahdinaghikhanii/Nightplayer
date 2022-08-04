import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../module/constans.dart';
import '../../module/extention.dart';
import '../../module/widgets.dart';
import '../bottom_sheet/moreiteam_bottomsheet.dart';
import '../search.dart';

class AllSong extends StatelessWidget {
  final ScrollController allSongContoroller;
  const AllSong({Key? key, required this.allSongContoroller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OnAudioQuery audioQuery = OnAudioQuery();
    PageStorageKey songStoregeKey = const PageStorageKey("song_pas");
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constans.kdefultAppColor,
          automaticallyImplyLeading: false,
          leadingWidth: 0,
          elevation: 0,
          titleSpacing: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constans.kdefualtAppPading),
              child: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: Search(),
                      query: "",
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.search,
                    size: 26,
                  )),
            )
          ],
          title: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constans.kdefualtAppPading),
            child: Text(
              'NightPlayer',
              style: context.textTheme.subtitle1!.copyWith(fontSize: 22),
            ),
          ),
          centerTitle: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: FutureBuilder<List<SongModel>>(
                    future: audioQuery.querySongs(
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true,
                    ),
                    builder: (context, iteam) {
                      if (iteam.data == null) {
                        return const Center(child: MWating());
                      }

                      if (iteam.data!.isEmpty) {
                        return const MNotFound();
                      }

                      context.audioCuibt.updateListSong(iteam.data!);

                      return DraggableScrollbar.arrows(
                        controller: allSongContoroller,
                        child: ListView.builder(
                            key: songStoregeKey,
                            padding: EdgeInsets.zero,
                            physics: const ScrollPhysics(),
                            itemCount:
                                context.audioCuibt.selectedSongforPLay.length,
                            itemExtent: 75,
                            primary: false,
                            controller: allSongContoroller,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ShowItemSong(
                                  onTapMoreIteam: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) => MBottomSheet(
                                            titleText: "More item",
                                            index: index));
                                  },
                                  ontap: () async {
                                    context.audioCuibt.setIndex(index);
                                    context.audioCuibt.playAudio(index);
                                    context.audioCuibt.showMusicNotification(
                                      iteam.data![index].id.toString(),
                                      iteam.data![index].title,
                                      iteam.data![index].artist ?? "No Artist",
                                      index,
                                    );
                                  },
                                  imgId: index,
                                  titleSongIndex: index,
                                  artistSongIndex: index);
                            }),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
