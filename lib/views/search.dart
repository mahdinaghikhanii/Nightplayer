import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../module/constans.dart';
import '../module/extention.dart';
import '../module/widgets.dart';
import 'playorstopsong.dart';

class Search extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        hintColor: Constans.kwhite,
        textTheme: const TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: 18)));
  }

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
    return const MNotFound();
  }

  // baraye respone serach
  @override
  Widget buildSuggestions(BuildContext context) {
    context.audioCuibt.searchInListforFindArtist(query);
    return query == ''
        ? const MNotFound()
        : ListView.builder(
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
                        nullArtworkWidget: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Constans.kdefualtBorderRadios)),
                          child: Image.asset(
                            'assets/img/null.jpg',
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                        artworkBorder: BorderRadius.circular(
                            Constans.kdefualtBorderRadios),
                        artworkWidth: 45,
                        artworkHeight: 45,
                        id: context.audioCuibt.allsongmodelList[index].id,
                        type: ArtworkType.AUDIO),
                    textColor: Colors.white,
                    title: Text(context
                        .audioCuibt.allsongmodelList[index].artist
                        .toString())),
              );
            });
  }
}
