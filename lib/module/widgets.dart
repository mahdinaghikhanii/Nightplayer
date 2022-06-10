import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nightplayer/module/constans.dart';

import 'extention.dart';

class MSmallListTile extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Function()? ontap;

  const MSmallListTile({Key? key, this.icon, this.text, this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
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
      // onTap: (val) => _menu.setValue(val),
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
  final String musiciansName;
  final String imgTruck;
  final double? paddigTopSize;
  final Function() ontap;
  const MListTileForMusic(
      {Key? key,
      required this.musiciansName,
      required this.ontap,
      required this.truckName,
      this.paddigTopSize,
      required this.imgTruck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddigTopSize ?? 0),
      child: SizedBox(
        child: Row(
          children: [
            MCircleImage(img: imgTruck),
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
                onPressed: () {},
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
