import 'package:flutter/material.dart';
import 'package:nightplayer/module/extention.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Search extends SearchDelegate<String> {
  var listSearch = [];
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
        itemCount: listSearch.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: ListTile(
              title: listSearch[index],
            ),
          );
        });
  }

  someName() async {
    buildSuggestionsSuccess() async {
      final OnAudioQuery _audioQuery = OnAudioQuery();

      // GenreSortType.NAME,
      // OrderType.ASC_OR_SMALLER

      /*listSearch = query.isEmpty
        ? []
        : something.where(((element) => element.startsWith(query))).toList();
     

    //return ListView.builder(itemBuilder: )*/
    }
  }
}
