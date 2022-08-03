import 'package:flutter/material.dart';
import 'package:nightplayer/module/constans.dart';
import 'package:nightplayer/module/extention.dart';
import 'package:nightplayer/module/widgets.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';
import 'package:on_audio_room/on_audio_room.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            future: OnAudioRoom()
                .queryFavorites(limit: 50, reverse: false, sortType: null),
            builder: ((context, item) {
              if (item.data == null) {
                return const MWating();
              }
              if (item.data!.isEmpty) {
                return const MNotFound();
              }
              List<FavoritesEntity> favorite = item.data!;

              return ListView.builder(
                  itemCount: favorite.length,
                  itemBuilder: (context, index) {
                    return ShowItemSongFavorite(
                        onTapMoreIteam: () {},
                        ontap: () {},
                        imgId: favorite[index].id,
                        titleSong: favorite[index].title,
                        artistSong: favorite[index].artist ?? "No Artist");
                  });
            })));
  }
}
