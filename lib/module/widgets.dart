import 'package:animate_do/animate_do.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../bloc/audio_bloc/audio_cubit.dart';
import '../bloc/audio_bloc/audio_state.dart';
import '../bloc/btnnavigation_bloc/btmnavigation_cubit.dart';
import '../bloc/btnnavigation_bloc/btmnavigation_state.dart';
import '../bloc/buildchip_bloc/buildchip_cubit.dart';
import '../bloc/buildchip_bloc/buildchip_state.dart';
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
              blurEffect: true,
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
  final Function()? ontap;
  const MButtonForSong(
      {Key? key,
      required this.icon,
      this.ontap,
      this.boxColor = false,
      this.colorIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
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
  final String? text;
  final double? fontsize;
  final double? imgSize;
  const MNotFound({Key? key, this.text, this.fontsize, this.imgSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/img/notfound.png',
          width: imgSize ?? 250,
        ),
        Text(
          text ?? 'No song found',
          style:
              context.textTheme.subtitle1!.copyWith(fontSize: fontsize ?? 24),
        ),
      ],
    ));
  }
}

class MCricleButton extends StatelessWidget {
  final double? sizeWith;
  final double? sizeHeight;
  final AudioState audioState;
  const MCricleButton(
      {Key? key, this.sizeHeight, this.sizeWith, required this.audioState})
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
      child: audioState is Pause
          ? IconButton(
              onPressed: () {
                context.audioCuibt.resumeSong();
              },
              icon: const Icon(Icons.play_arrow, color: Colors.white))
          : IconButton(
              onPressed: () {
                context.audioCuibt.pauseAudio();
              },
              icon: const Icon(Icons.pause, color: Colors.white)),
    );
  }
}

class MMiniPlayer extends StatelessWidget {
  const MMiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, AudioState>(
      builder: (context, state) {
        if (state is ShowMiniPLayer ||
            state is Pause ||
            state is Next ||
            state is Back) {
          return FadeInRight(
              child: GestureDetector(
            onTap: () => context.nextPage(const PlayOrStopSong()),
            child: StreamBuilder<int?>(
                stream: context.audioCuibt.player.currentIndexStream,
                builder: (context, snapshot) {
                  final currentIndex = snapshot.data;
                  if (currentIndex != null) {
                    return Container(
                        width: double.infinity,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  Constans.kdefualtBorderRadios),
                              topRight: Radius.circular(
                                  Constans.kdefualtBorderRadios)),
                          color: Colors.grey,
                        ),
                        height: 70,
                        child: GestureDetector(
                          child: ListTile(
                              subtitle: Text(
                                  context
                                      .audioCuibt
                                      .selectedSongforPLay[
                                          context.audioCuibt.index]
                                      .title
                                      .toString(),
                                  softWrap: false,
                                  overflow: TextOverflow.clip,
                                  style: context.textTheme.bodyText1!.copyWith(
                                      fontSize: 12, color: Colors.white)),
                              leading: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Constans.kdefualtBorderRadios)),
                                child: QueryArtworkWidget(
                                    nullArtworkWidget: Image.asset(
                                      'assets/img/null.jpg',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.fill,
                                    ),
                                    artworkBorder: BorderRadius.circular(
                                        Constans.kdefualtBorderRadios),
                                    artworkWidth: 60,
                                    artworkHeight: 60,
                                    id: context
                                        .audioCuibt
                                        .selectedSongforPLay[
                                            context.audioCuibt.index]
                                        .id,
                                    type: ArtworkType.AUDIO),
                              ),
                              textColor: Colors.white,
                              trailing: MCricleButton(audioState: state),
                              title: Text(
                                context
                                    .audioCuibt
                                    .selectedSongforPLay[
                                        context.audioCuibt.index]
                                    .artist
                                    .toString(),
                                softWrap: false,
                                overflow: TextOverflow.clip,
                                style: context.textTheme.subtitle1!.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                        ));
                  }

                  return const MWating();
                }),
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
    List choice = ["Artists", "PlayList"];
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
                            .getBuildChipIteam(BuildChip.playlist);
                      } else if (index == 2) {}
                    }),
              );
            },
          ),
        );
      },
    );
  }
}

class MEdit extends StatelessWidget {
  final String hint;
  final Function(String)? onChange;
  final bool autoFocus;
  final bool notempty;

  final TextEditingController? controller;
  final bool password;

  const MEdit(
      {required this.hint,
      required this.autoFocus,
      required this.password,
      this.notempty = false,
      this.controller,
      this.onChange,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Constans.kdefualtAppPading, right: Constans.kdefualtAppPading),
      child: TextFormField(
          controller: controller,
          onChanged: onChange,
          validator: (val) {
            if ((val ?? '').isEmpty && notempty) {
              return "cannot be empty";
            }
            return null;
          },
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Constans.kdefualtBorderRadios),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Constans.kdefualtBorderRadios),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  )),
              fillColor: Colors.red,
              hoverColor: Colors.red,
              suffixIconColor: Colors.red,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), gapPadding: 10),
              labelText: hint,
              labelStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16)),
          obscureText: password),
    );
  }
}

class MIconButton extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Function()? ontap;
  final Color? color;
  const MIconButton(
      {Key? key, required this.icon, this.ontap, this.size, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Icon(
        icon,
        size: size ?? Constans.kdefualtSizeIcon,
        color: color ?? Colors.white,
      ),
    );
  }
}

class MListTileForBottomSheet extends StatelessWidget {
  final String text;
  final Color? iconColor;
  final IconData? icon;
  final Function() ontap;
  final TextStyle? textStyle;
  const MListTileForBottomSheet(
      {Key? key,
      required this.text,
      this.icon,
      this.iconColor,
      this.textStyle,
      required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(text, style: textStyle ?? context.textTheme.subtitle1),
      onTap: ontap,
      //trailing: Icon(icon));
    );
  }
}

class BuildListTile extends StatelessWidget {
  const BuildListTile(
      {Key? key,
      required this.visibilityArrowIcons,
      required this.ontap,
      required this.color,
      required this.icon,
      this.subtitleIcon,
      required this.title,
      this.textStyle,
      required this.trailing})
      : super(key: key);
  final String title, trailing;
  final IconData icon;
  final Color color;
  final IconData? subtitleIcon;
  final bool visibilityArrowIcons;
  final Function() ontap;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var borderRadius = const BorderRadius.all(Radius.circular(32));
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          contentPadding: const EdgeInsets.all(0),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: color.withAlpha(30)),
            child: Center(
              child: Icon(
                icon,
                color: color,
              ),
            ),
          ),
          title: Text(title,
              style: textStyle ?? textTheme.headline6?.copyWith(fontSize: 17)),
          trailing: SizedBox(
            width: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(trailing,
                    style: textTheme.headline6
                        ?.copyWith(color: Colors.grey.shade600, fontSize: 15)),
                Visibility(
                  visible: visibilityArrowIcons,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          onTap: ontap),
    );
  }
}

class ShowItemSong extends StatelessWidget {
  final Function() onTapMoreIteam;
  final Function() ontap;
  final int imgId;
  final int titleSongIndex;
  final int artistSongIndex;
  const ShowItemSong(
      {Key? key,
      required this.onTapMoreIteam,
      required this.ontap,
      required this.imgId,
      required this.titleSongIndex,
      required this.artistSongIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      width: double.infinity,
      height: 70,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: ontap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: QueryArtworkWidget(
                  nullArtworkWidget: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Constans.kdefualtAppPading)),
                      child: Image.asset('assets/img/null.jpg',
                          width: 60, height: 60, fit: BoxFit.cover)),
                  artworkBorder:
                      BorderRadius.circular(Constans.kdefualtBorderRadios),
                  artworkWidth: 60,
                  artworkHeight: 60,
                  id: context.audioCuibt.selectedSongforPLay[imgId].id,
                  type: ArtworkType.AUDIO),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    height: 24,
                    child: Text(
                      context
                          .audioCuibt.selectedSongforPLay[titleSongIndex].title,
                      overflow: TextOverflow.ellipsis,
                      style:
                          context.textTheme.subtitle1!.copyWith(fontSize: 16),
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                Expanded(
                  child: SizedBox(
                    width: 180,
                    height: 24,
                    child: Text(
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.clip,
                        context.audioCuibt.selectedSongforPLay[artistSongIndex]
                                .artist ??
                            "No Artist",
                        style: context.textTheme.subtitle1!
                            .copyWith(fontSize: 14)),
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: onTapMoreIteam,
                icon: Icon(
                  Icons.more_horiz,
                  size: 35,
                  color: Constans.kwhite,
                ))
          ],
        ),
      ),
    );
  }
}

class ShowItemSongFavorite extends StatelessWidget {
  final Function() onTapFavoriteIteam;
  final Function() ontap;
  final int imgId;
  final String titleSong;
  final String artistSong;
  const ShowItemSongFavorite(
      {Key? key,
      required this.onTapFavoriteIteam,
      required this.ontap,
      required this.imgId,
      required this.titleSong,
      required this.artistSong})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      width: double.infinity,
      height: 75,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: ontap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: QueryArtworkWidget(
                  nullArtworkWidget: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Constans.kdefualtAppPading)),
                      child: Image.asset('assets/img/null.jpg',
                          width: 60, height: 60, fit: BoxFit.cover)),
                  artworkBorder:
                      BorderRadius.circular(Constans.kdefualtBorderRadios),
                  artworkWidth: 60,
                  artworkHeight: 60,
                  id: imgId,
                  type: ArtworkType.AUDIO),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    height: 24,
                    child: Text(
                      titleSong,
                      overflow: TextOverflow.ellipsis,
                      style:
                          context.textTheme.subtitle1!.copyWith(fontSize: 16),
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                Expanded(
                  child: SizedBox(
                    width: 180,
                    height: 24,
                    child: Text(
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.clip,
                        artistSong,
                        style: context.textTheme.subtitle1!
                            .copyWith(fontSize: 14)),
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: onTapFavoriteIteam,
                icon: const Icon(Icons.favorite, size: 22, color: Colors.white))
          ],
        ),
      ),
    );
  }
}

class CustomSnackAlert {
  static SnackBar showErrorSnackBar(String message) {
    return SnackBar(
      content: Text(message,
          style: TextStyle(
              color: Constans.navyblueshade2,
              fontSize: 16,
              fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 4),
    );
  }
}

class ToastRemoveOrAdd extends StatelessWidget {
  final int index;
  const ToastRemoveOrAdd({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          index == 0
              ? Icon(
                  Icons.favorite,
                  color: Constans.navyblueshade2,
                )
              : Icon(
                  Icons.delete,
                  color: Constans.navyblueshade2,
                ),
          const SizedBox(width: 12.0),
          Text(
              index == 0
                  ? "done ! save in favorite song"
                  : "done ! remove in favorite song",
              style: context.textTheme.subtitle1!
                  .copyWith(color: Constans.navyblueshade2)),
        ],
      ),
    );
  }
}
