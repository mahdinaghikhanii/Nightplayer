import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

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
  const MCircleImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        height: 40,
        child: Column(
          children: [CircleAvatar()],
        ));
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
        /// Home
        DotNavigationBarItem(
          icon: const Icon(Icons.home),
          selectedColor: Colors.purple,
        ),

        /// Likes
        DotNavigationBarItem(
          icon: const Icon(Icons.favorite_border),
          selectedColor: Colors.pink,
        ),

        /// Search
        DotNavigationBarItem(
          icon: const Icon(Icons.search),
          selectedColor: Colors.orange,
        ),

        /// Profile
        DotNavigationBarItem(
          icon: const Icon(Icons.person),
          selectedColor: Colors.teal,
        ),
      ],
    );
  }
}
