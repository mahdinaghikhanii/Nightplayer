import 'package:flutter/material.dart';

import '../../module/constans.dart';
import '../../module/extention.dart';
import '../../module/widgets.dart';

class DlialogCreatePlayList extends StatelessWidget {
  const DlialogCreatePlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Constans.navyblueshade2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: SizedBox(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Give your playlist a name.",
                  style: context.textTheme.subtitle1),
              const MEdit(hint: "", autoFocus: false, password: false),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Constans.navyblueshade2, elevation: 0),
                      onPressed: () {
                        context.back();
                      },
                      child: Text(
                        "Close",
                        style: context.textTheme.button!
                            .copyWith(color: Colors.grey),
                      )),
                  const SizedBox(width: 40),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Constans.navyblueshade2,
                      ),
                      onPressed: () {
                        context.back();
                      },
                      child: Text("Skip",
                          style: context.textTheme.button!
                              .copyWith(color: Colors.white)))
                ],
              )
            ],
          ),
        ));
  }
}
