import 'package:flutter/material.dart';
import 'package:nightplayer/module/constans.dart';

import '../module/extention.dart';

class PlayOrStopSong extends StatelessWidget {
  const PlayOrStopSong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: IconButton(
            onPressed: () => context.back(),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: Constans.kdefualtAppPading,
              right: Constans.kdefualtAppPading,
            ),
            child: Expanded(
                flex: 2,
                child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(40)),
                    child: Image.asset('assets/img/kaj.jpg'))),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                children: [],
              ),
            ),
          )
        ],
      ),
    );
  }
}
