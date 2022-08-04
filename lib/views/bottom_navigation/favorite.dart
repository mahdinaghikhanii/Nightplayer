import 'package:flutter/material.dart';
import 'package:on_audio_room/on_audio_room.dart';

import '../../module/constans.dart';
import '../../module/extention.dart';
import '../../module/widgets.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final OnAudioRoom audioRoom = OnAudioRoom();
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
              'Favorite',
              style: context.textTheme.subtitle1!.copyWith(fontSize: 22),
            ),
          ),
          centerTitle: false,
        ),
        body: FutureBuilder<List<FavoritesEntity>>(
            future: OnAudioRoom().queryFavorites(
                limit: 50, reverse: false, sortType: RoomSortType.DATE_ADDED),
            builder: ((context, item) {
              if (item.data == null) {
                return const Center(child: MWating());
              }
              if (item.data!.isEmpty) {
                return const Center(child: MNotFound());
              }
              context.audioCuibt.updateFavorite(item.data!);
              var fav = context.audioCuibt.listfavorite;

              return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: fav.length,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemExtent: 75,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ShowItemSongFavorite(
                        onTapFavoriteIteam: () async {
                          await audioRoom.deleteFrom(
                              RoomType.FAVORITES, fav[index].key);
                          setState(() {});
                        },
                        ontap: () {},
                        imgId: fav[index].id,
                        titleSong: fav[index].title,
                        artistSong: fav[index].artist ?? "No Artist");
                  });
            })));
  }
}
