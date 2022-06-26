import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/audio_bloc/audio_state.dart';
import '../bloc/btnnavigation_bloc/btmnavigation_cubit.dart';
import '../bloc/btnnavigation_bloc/btmnavigation_state.dart';
import '../module/constans.dart';
import '../module/extention.dart';
import '../module/navbar_items.dart';
import '../module/widgets.dart';
import 'allsong.dart';
import 'search.dart';

class Home extends StatelessWidget {
  final AudioState stateaudio;
  const Home({Key? key, required this.stateaudio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: const MBottomNavigation(),
        appBar: AppBar(
          backgroundColor: Constans.kdefultAppColor,
          automaticallyImplyLeading: false,
          leadingWidth: 0,
          elevation: 0,
          titleSpacing: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constans.kdefualtAppPading),
              child: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: Search(),
                      query: "",
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.search,
                    size: 26,
                  )),
            )
          ],
          title: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constans.kdefualtAppPading),
            child: Text(
              'NightPlayer',
              style: context.textTheme.subtitle1!.copyWith(fontSize: 22),
            ),
          ),
          centerTitle: false,
        ),
        body: BlocBuilder<BtmNavigationCubit, BtmNavigationState>(
            builder: ((context, state) {
          if (state.navbarItem == NavbarItem.allsong) {
            return const AllSong();
          }
          return Container();
        })));
  }
}
