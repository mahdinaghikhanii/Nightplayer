import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../module/extention.dart';
import 'playorstopsong.dart';

class Search extends SearchDelegate<String> {
  var listSearch = [];

  List<dynamic> something = [];
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              query = '';
              print(something);
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
        const Icon(Icons.confirmation_num, size: 120),
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
    return ListView.builder(
        itemCount: something.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () =>
                context.nextPage(PlayOrStopSong(songModel: listSearch[index])),
            child: ListTile(
              textColor: Colors.white,
              tileColor: Colors.black,
              title: something[index],
            ),
          );
        });
  }

  buildSuggestionsSuccess() async {
    //  List<dynamic> something
    final OnAudioQuery _audioQuery = OnAudioQuery();
    something = await _audioQuery.queryWithFilters(
      query,
      WithFiltersType.AUDIOS,
      args: AudiosArgs.ARTIST,
    );
  }
}
