import 'package:flutter/material.dart';

import '../module/extention.dart';
import '../module/widgets.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  child: Image.asset('assets/img/kaj.jpg')),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Kaj",
                            style: context.textTheme.subtitle1!
                                .copyWith(fontSize: 26),
                          ),
                          const Spacer(),
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white.withAlpha(30)),
                            child: const Center(
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        "Mehrad Hidden",
                        style: context.textTheme.subtitle1!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container()),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        children: [
                          Text(
                            "2:13",
                            style: context.textTheme.subtitle1,
                          ),
                          const Spacer(),
                          Text(
                            "4:10",
                            style: context.textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          MButtonForSong(
                            icon: Icons.arrow_back_ios,
                          ),
                          SizedBox(width: 20),
                          MButtonForSong(
                            icon: Icons.play_arrow,
                            boxColor: true,
                          ),
                          SizedBox(width: 20),
                          MButtonForSong(icon: Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
