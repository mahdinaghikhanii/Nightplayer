import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/btnnavigation_bloc/btmnavigation_cubit.dart';
import '../bloc/btnnavigation_bloc/btmnavigation_state.dart';
import '../module/enum.dart';
import '../module/widgets.dart';
import 'bottom_navigation/allsong.dart';
import 'bottom_navigation/favorite.dart';
import 'bottom_navigation/handler_buildchip.dart';
import 'bottom_navigation/settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController albumContoroller = ScrollController();
  ScrollController allsongContoroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: const MBottomNavigation(),
        body: BlocBuilder<BtmNavigationCubit, BtmNavigationState>(
            builder: ((context, state) {
          if (state.navbarItem == NavbarItem.allsong) {
            return AllSong(allSongContoroller: allsongContoroller);
          } else if (state.navbarItem == NavbarItem.album) {
            return HandlerBuildChip(albumContoroller: albumContoroller);
          } else if (state.navbarItem == NavbarItem.favorite) {
            return const Favorite();
          } else if (state.navbarItem == NavbarItem.settings) {
            return const Settings();
          }

          return Container();
        })));
  }
}
