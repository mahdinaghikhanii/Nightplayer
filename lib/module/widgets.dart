import 'package:animate_do/animate_do.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/bloc/buildchip_bloc/buildchip_cubit.dart';
import 'package:nightplayer/bloc/buildchip_bloc/buildchip_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../bloc/audio_bloc/audio_cubit.dart';
import '../bloc/audio_bloc/audio_state.dart';
import '../bloc/btnnavigation_bloc/btmnavigation_cubit.dart';
import '../bloc/btnnavigation_bloc/btmnavigation_state.dart';
import '../views/playorstopsong.dart';
import 'constans.dart';
import 'enum.dart';
import 'extention.dart';

class MSmallListTile extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Function()? ontapIconButtonMore;

  const MSmallListTile(
      {Key? key, this.icon, this.text, this.ontapIconButtonMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapIconButtonMore,
      child: Row(
        children: [
          Text(
            text ?? '',
            style: context.textTheme.subtitle1,
          ),
          const Spacer(),
          Icon(icon)
        ],
      ),
    );
  }
}

class MCircleImage extends StatelessWidget {
  final String img;
  final double? withs;
  final double? heights;

  const MCircleImage({
    Key? key,
    this.heights,
    this.withs,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: Image.asset(
        img,
        fit: BoxFit.fill,
      ),
    );
  }
}

class MBottomNavigation extends StatelessWidget {
  const MBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BtmNavigationCubit, BtmNavigationState>(
      builder: (BuildContext context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const MMiniPlayer(),
            CustomNavigationBar(
              iconSize: 30.0,
              selectedColor: Colors.white,
              strokeColor: const Color(0x30040307),
              unSelectedColor: const Color(0xffacacac),
              backgroundColor: Constans.kdefultAppColor,
              items: [
                CustomNavigationBarItem(
                  icon: const Icon(Icons.home),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(Icons.library_music),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(Icons.favorite),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                ),
              ],
              currentIndex: state.index,
              onTap: (index) {
                if (index == 0) {
                  BlocProvider.of<BtmNavigationCubit>(context)
                      .getNavbarItem(NavbarItem.allsong);
                } else if (index == 1) {
                  BlocProvider.of<BtmNavigationCubit>(context)
                      .getNavbarItem(NavbarItem.album);
                } else if (index == 2) {
                  BlocProvider.of<BtmNavigationCubit>(context)
                      .getNavbarItem(NavbarItem.favorite);
                } else if (index == 3) {
                  BlocProvider.of<BtmNavigationCubit>(context)
                      .getNavbarItem(NavbarItem.settings);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class MListTileForMusic extends StatelessWidget {
  final String truckName;
  final VoidCallback ontap;
  final String musiciansName;
  final String imgTruck;
  final double? paddigTopSize;
  final Function() ontapIconButtonMore;
  const MListTileForMusic(
      {Key? key,
      required this.musiciansName,
      required this.ontap,
      required this.ontapIconButtonMore,
      required this.truckName,
      this.paddigTopSize,
      required this.imgTruck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.only(top: paddigTopSize ?? 0),
        child: SizedBox(
          child: Row(
            children: [
              MCircleImage(
                img: imgTruck,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    truckName,
                    style: context.textTheme.subtitle1,
                  ),
                  const SizedBox(height: 15),
                  Text(musiciansName, style: context.textTheme.subtitle1),
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: ontapIconButtonMore,
                  icon: Icon(
                    Icons.more_horiz,
                    size: 35,
                    color: Constans.kwhite,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class MButtonForSong extends StatelessWidget {
  final IconData icon;
  final bool boxColor;
  final Color? colorIcon;
  const MButtonForSong(
      {Key? key, required this.icon, this.boxColor = false, this.colorIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: boxColor ? Colors.white.withAlpha(30) : null),
      child: Center(
        child: Icon(
          icon,
          color: colorIcon ?? Colors.white,
          size: 40,
        ),
      ),
    );
  }
}

class MWating extends StatelessWidget {
  const MWating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(
            color: Colors.white,
            radius: 18,
          ),
          const SizedBox(height: 20),
          Text(
            'Pls wait',
            style: context.textTheme.bodyText1!.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class MNotFound extends StatelessWidget {
  const MNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/img/notfound.png',
          width: 250,
        ),
        Text(
          'No song found',
          style: context.textTheme.subtitle1!.copyWith(fontSize: 24),
        ),
      ],
    ));
  }
}

class MCricleButton extends StatelessWidget {
  final double? sizeWith;
  final double? sizeHeight;
  const MCricleButton({Key? key, this.sizeHeight, this.sizeWith})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeWith ?? 40,
      height: sizeHeight ?? 40,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.white,
          offset: Offset(
            0.0,
            0.0,
          ),
          blurRadius: 2.0,
          spreadRadius: 1.0,
        ), //BoxShadow
        BoxShadow(
          color: Colors.white,
          offset: Offset(0.0, 0.0),
          blurRadius: 2.0,
          spreadRadius: 1.0,
        ),
      ], shape: BoxShape.circle, color: Constans.kdefultAppColor),
      child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.play_arrow, color: Colors.white)),
    );
  }
}

class MMiniPlayer extends StatelessWidget {
  final SongModel? songModel;
  const MMiniPlayer({Key? key, this.songModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, AudioState>(
      builder: (context, state) {
        if (state is ShowMiniPLayer) {
          return FadeInRight(
              child: GestureDetector(
            onTap: () => context.nextPage(
                PlayOrStopSong(songModel: context.audioCuibt.song[0])),
            child: Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Constans.kdefualtBorderRadios),
                      topRight: Radius.circular(Constans.kdefualtBorderRadios)),
                  color: Colors.grey,
                ),
                height: 70,
                child: GestureDetector(
                  child: ListTile(
                      subtitle: Text(
                          context.audioCuibt.song[0].title.toString(),
                          style: context.textTheme.bodyText1!
                              .copyWith(fontSize: 12, color: Colors.white)),
                      leading: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Constans.kdefualtBorderRadios)),
                        child: QueryArtworkWidget(
                            nullArtworkWidget: Image.asset(
                              'assets/icon/song248.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.fill,
                            ),
                            artworkBorder: BorderRadius.circular(
                                Constans.kdefualtBorderRadios),
                            artworkWidth: 60,
                            artworkHeight: 60,
                            id: context.audioCuibt.song[0].id,
                            type: ArtworkType.AUDIO),
                      ),
                      textColor: Colors.white,
                      trailing: const MCricleButton(),
                      title: Text(
                        context.audioCuibt.song[0].artist.toString(),
                        style: context.textTheme.subtitle1!.copyWith(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                )),
          ));
        } else {
          return Container();
        }
      },
    );
  }
}

class MBuildChip extends StatelessWidget {
  const MBuildChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List choice = ["Artists", "Album", "PlayList"];
    return BlocBuilder<BuildChipCubit, BuildChipState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: choice.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(right: 5, left: 5),
                child: ChoiceChip(
                    backgroundColor: Constans.kdefultAppColor.withOpacity(0.8),
                    label: Text(
                      choice[index],
                      style: context.textTheme.subtitle1,
                    ),
                    selectedColor: Colors.grey,
                    selected: state.index == index,
                    onSelected: (select) {
                      if (index == 0) {
                        BlocProvider.of<BuildChipCubit>(context)
                            .getBuildChipIteam(BuildChip.artist);
                      } else if (index == 1) {
                        BlocProvider.of<BuildChipCubit>(context)
                            .getBuildChipIteam(BuildChip.album);
                      } else if (index == 2) {
                        BlocProvider.of<BuildChipCubit>(context)
                            .getBuildChipIteam(BuildChip.playlist);
                      }
                    }),
              );
            },
          ),
        );
      },
    );
  }
}
