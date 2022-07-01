import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/audio_bloc/audio_state.dart';
import '../bloc/btnnavigation_bloc/btmnavigation_cubit.dart';
import '../bloc/btnnavigation_bloc/btmnavigation_state.dart';
import '../module/enum.dart';
import '../module/widgets.dart';
import 'album.dart';
import 'allsong.dart';
import 'favorite.dart';
import 'settings.dart';

class Home extends StatelessWidget {
  final AudioState stateaudio;
  const Home({Key? key, required this.stateaudio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: const MBottomNavigation(),
        body: BlocBuilder<BtmNavigationCubit, BtmNavigationState>(
            builder: ((context, state) {
          if (state.navbarItem == NavbarItem.allsong) {
            return const AllSong();
          } else if (state.navbarItem == NavbarItem.album) {
            return const Album();
          } else if (state.navbarItem == NavbarItem.favorite) {
            return const Favorite();
          } else if (state.navbarItem == NavbarItem.settings) {
            return const Settings();
          }

          return Container();
        })));
  }
}
