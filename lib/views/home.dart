import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../bloc/statebloc.dart';
import '../module/constans.dart';
import '../module/extention.dart';
import '../module/widgets.dart';

class Home extends StatelessWidget {
  final StateBloc stateBloc;
  const Home({Key? key, required this.stateBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OnAudioQuery _audioQuery = OnAudioQuery();
    return Scaffold(
      // bottomNavigationBar: const MBottomNavigation(),
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
                onPressed: () {},
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
      body: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: Constans.kdefualtAppPading),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const MSmallListTile(
              text: "All Song",
            ),
            Expanded(
                child: FutureBuilder<List<SongModel>>(
                    future: _audioQuery.querySongs(
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true,
                    ),
                    builder: (context, iteam) {
                      if (iteam.data == null) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }
                      if (iteam.data!.isEmpty) {
                        return Center(
                            child: Text(
                          'No song found',
                          style: context.textTheme.subtitle1,
                        ));
                      }
                      return ListView.builder(
                          itemCount: iteam.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: SizedBox(
                                    child: Row(
                                      children: [
                                        QueryArtworkWidget(
                                            nullArtworkWidget:
                                                const MCircleImage(
                                              img: 'assets/img/kaj.jpg',
                                            ),
                                            artworkBorder:
                                                BorderRadius.circular(10),
                                            artworkWidth: 65,
                                            artworkHeight: 75,
                                            artworkRepeat: ImageRepeat.noRepeat,
                                            id: iteam.data![index].id,
                                            type: ArtworkType.AUDIO),
                                        const SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              iteam.data![index].title.length >
                                                      10
                                                  ? '${iteam.data![index].title.substring(0, 13)}..'
                                                  : iteam.data![index].title,
                                              style: context
                                                  .textTheme.subtitle1!
                                                  .copyWith(fontSize: 16),
                                              maxLines: 1,
                                            ),
                                            const SizedBox(height: 10),
                                            Text(iteam.data![index].displayName,
                                                style: context
                                                    .textTheme.subtitle1),
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
                              ),
                            );
                          });
                    }))
          ],
        ),
      ),
    );
  }
}
