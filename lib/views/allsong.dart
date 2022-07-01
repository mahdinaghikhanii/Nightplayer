import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../module/constans.dart';
import '../module/extention.dart';
import '../module/widgets.dart';
import 'search.dart';

class AllSong extends StatelessWidget {
  const AllSong({Key? key}) : super(key: key);

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
            child: FutureBuilder<List<SongModel>>(
                future: audioQuery.querySongs(
                  sortType: null,
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

                  return ListView.builder(
                      physics: const ScrollPhysics(),
                      itemCount: iteam.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          width: double.infinity,
                          height: 70,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () async {
                              context.audioCuibt.showMusicNotification(
                                iteam.data![index].id.toString(),
                                // 'assets/icon/song248.png',
                                iteam.data![index].title,
                                iteam.data![index].artist ?? "No Artist",
                                index,
                              );

                              /*     context.nextPage(PlayOrStopSong(
                                  songModel: iteam.data![index]));*/

                              context.audioCuibt.addData(iteam.data![index]);
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: QueryArtworkWidget(
                                      nullArtworkWidget: Image.asset(
                                        'assets/icon/song248.png',
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.fill,
                                      ),
                                      artworkBorder: BorderRadius.circular(
                                          Constans.kdefualtBorderRadios),
                                      artworkWidth: 60,
                                      artworkHeight: 60,
                                      id: iteam.data![index].id,
                                      type: ArtworkType.AUDIO),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: SizedBox(
                                        width: 200,
                                        height: 24,
                                        child: Text(
                                          iteam.data![index].title,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.textTheme.subtitle1!
                                              .copyWith(fontSize: 16),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 0),
                                    Expanded(
                                      child: SizedBox(
                                        width: 180,
                                        height: 24,
                                        child: Text(
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.clip,
                                            iteam.data![index].artist ??
                                                "No Artist",
                                            style: context.textTheme.subtitle1!
                                                .copyWith(fontSize: 14)),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: (() {}),
                                    icon: Icon(
                                      Icons.more_horiz,
                                      size: 35,
                                      color: Constans.kwhite,
                                    ))
                              ],
                            ),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
