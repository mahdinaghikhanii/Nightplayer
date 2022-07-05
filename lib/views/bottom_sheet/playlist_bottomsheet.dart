import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/bloc/playlist_bloc/playlist_cubit.dart';
import 'package:nightplayer/bloc/playlist_bloc/playlist_state.dart';
import 'package:nightplayer/module/constans.dart';
import 'package:nightplayer/module/extention.dart';
import 'package:nightplayer/module/widgets.dart';

class PlayListBottomSheet extends StatelessWidget {
  const PlayListBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayListCubit, PlayListState>(
      builder: (BuildContext context, state) {
        return Container(
          padding: const EdgeInsets.all(Constans.kdefualtAppPading),
          height: 260,
          decoration: BoxDecoration(
              color: Constans.kdefultAppColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )),
          child: Column(
            children: [
              MListTileForBottomSheet(
                text: "Remove",
                textStyle: context.textTheme.subtitle1,
                ontap: () {},
              )
            ],
          ),
        );
      },
    );
  }
}
