import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../module/extention.dart';
import 'playorstopsong.dart';

class Search extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              query = '';
            },
            icon: const Icon(
              Icons.clear,
            ))
      ];

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.back();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.confirmation_num,
          size: 120,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(query)
      ],
    ));
  }

  // baraye respone serach
  @override
  Widget buildSuggestions(BuildContext context) {
    context.audioCuibt.loadListSongForSearching(query);

    return ListView.builder(
        itemCount: context.audioCuibt.allsongmodelList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => context.nextPage(PlayOrStopSong(
                songModel: context.audioCuibt.allsongmodelList[index])),
            child: ListTile(
                subtitle:
                    Text(context.audioCuibt.allsongmodelList[index].title),
                leading: QueryArtworkWidget(
                    nullArtworkWidget: Image.asset(
                      'assets/icon/song248.png',
                      width: 65,
                      height: 65,
                      fit: BoxFit.fill,
                    ),
                    artworkBorder: BorderRadius.circular(10),
                    artworkWidth: 45,
                    artworkHeight: 45,
                    id: context.audioCuibt.allsongmodelList[index].id,
                    type: ArtworkType.AUDIO),
                textColor: Colors.white,
                title: Text(context.audioCuibt.allsongmodelList[index].artist
                    .toString())),
          );
        });
  }
}
