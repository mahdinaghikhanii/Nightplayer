import 'package:flutter/material.dart';

import '../../module/constans.dart';
import '../../module/extention.dart';
import '../../module/widgets.dart';

class MBottomSheet extends StatelessWidget {
  final String titleText;

  const MBottomSheet({Key? key, required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: 300,
      decoration: BoxDecoration(
          color: Constans.kdefultAppColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: context.textTheme.subtitle1,
          ),
          const SizedBox(height: 20),
          MListTileForBottomSheet(
            icon: Icons.favorite,
            iconColor: Colors.white,
            text: "Add favorite",
            textStyle: context.textTheme.subtitle1,
            ontap: () {},
          ),
        ],
      ),
    );
  }
}
