import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nightplayer/module/extention.dart';
import 'package:nightplayer/module/widgets.dart';
import 'package:nightplayer/views/playorstopsong.dart';
import 'package:nightplayer/views/search.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../module/constans.dart';

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
                      return const Center(child: CupertinoActivityIndicator());
                    }

                    if (iteam.data!.isEmpty) {
                      return const MNotFound();
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ListView.builder(
                          physics: const ScrollPhysics(),
                          itemCount: iteam.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              width: double.infinity,
                              height: 68,
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () async {
                                  context.audioCuibt.showMusicNotification(
                                      iteam.data![index].id.toString(),
                                      // 'assets/icon/song248.png',
                                      iteam.data![index].title,
                                      iteam.data![index].artist ?? "No Artist",
                                      index);
                                  context.nextPage(PlayOrStopSong(
                                      songModel: iteam.data![index]));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Row(
                                    children: [
                                      Hero(
                                        tag: iteam.data![index].id,
                                        child: QueryArtworkWidget(
                                            nullArtworkWidget: Image.asset(
                                              'assets/icon/song248.png',
                                              width: 65,
                                              height: 65,
                                              fit: BoxFit.fill,
                                            ),
                                            artworkBorder:
                                                BorderRadius.circular(10),
                                            artworkWidth: 65,
                                            artworkHeight: 65,
                                            id: iteam.data![index].id,
                                            type: ArtworkType.AUDIO),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 10),
                                          Expanded(
                                            child: SizedBox(
                                              width: 180,
                                              height: 24,
                                              child: Text(
                                                iteam.data![index].title,
                                                overflow: TextOverflow.fade,
                                                style: context
                                                    .textTheme.subtitle1!
                                                    .copyWith(fontSize: 16),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
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
                                                  style: context
                                                      .textTheme.subtitle1),
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
                              ),
                            );
                          }),
                    );
                  }))
        ],
      ),
    );
  }
}
