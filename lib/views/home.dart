import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nightplayer/module/extention.dart';
import 'package:nightplayer/module/widgets.dart';

import '../bloc/statebloc.dart';
import '../module/constans.dart';

class Home extends StatelessWidget {
  final StateBloc stateBloc;
  const Home({Key? key, required this.stateBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const MBottomNavigation(),
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
                onPressed: () {},
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
      body: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: Constans.kdefualtAppPading),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const MSmallListTile(
              text: "Song",
            ),
            const SizedBox(
              height: 20,
            ),
            MListTileForMusic(
              imgTruck: "assets/img/kaj.jpg",
              truckName: "Kaj",
              ontap: () {},
              musiciansName: "Mehrad Hedden",
            ),
            MListTileForMusic(
              paddigTopSize: 20,
              imgTruck: "assets/img/call.jpg",
              truckName: "Call of My name",
              ontap: () {},
              musiciansName: "The Weekend",
            ),
            MListTileForMusic(
              paddigTopSize: 20,
              imgTruck: "assets/img/kaj.jpg",
              truckName: "Kaj",
              ontap: () {},
              musiciansName: "Mehrad Hedden",
            ),
            MListTileForMusic(
              paddigTopSize: 20,
              imgTruck: "assets/img/kaj.jpg",
              truckName: "Kaj",
              ontap: () {},
              musiciansName: "Mehrad Hedden",
            )
          ],
        ),
      ),
    );
  }
}
