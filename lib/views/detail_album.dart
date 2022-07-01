import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../module/constans.dart';
import '../module/extention.dart';

class DetailAlbum extends StatelessWidget {
  final AlbumModel albumModel;
  const DetailAlbum({Key? key, required this.albumModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constans.kdefualtAppPading,
                ),
                child: IconButton(
                  onPressed: (() => context.back()),
                  iconSize: Constans.kdefualtSizeIcon,
                  icon: const Icon(Icons.more_vert),
                ))
          ],
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constans.kdefualtAppPading,
            ),
            child: IconButton(
                onPressed: (() => context.back()),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: Constans.kdefualtSizeIcon,
                )),
          )),
      body: Column(
        children: [],
      ),
    );
  }
}
