import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constans.dart';
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
    return DotNavigationBar(
      //   currentIndex: _menu.value,
      // ontapIconButtonMore: (val) => _menu.setValue(val),
      // dotIndicatorColor: Colors.black,
      items: [
        DotNavigationBarItem(
          icon: const Icon(Icons.home),
          selectedColor: Colors.purple,
        ),
        DotNavigationBarItem(
          icon: const Icon(Icons.favorite_border),
          selectedColor: Colors.pink,
        ),
        DotNavigationBarItem(
          icon: const Icon(Icons.search),
          selectedColor: Colors.orange,
        ),
        DotNavigationBarItem(
          icon: const Icon(Icons.person),
          selectedColor: Colors.teal,
        ),
      ],
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
    return const Center(
      child: CupertinoActivityIndicator(),
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
