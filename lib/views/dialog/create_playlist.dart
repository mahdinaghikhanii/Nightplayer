import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nightplayer/bloc/playlist_bloc/playlist_cubit.dart';
import 'package:nightplayer/bloc/playlist_bloc/playlist_state.dart';

import '../../module/constans.dart';
import '../../module/extention.dart';
import '../../module/widgets.dart';

TextEditingController _namePlayListContoroller = TextEditingController();

class DlialogCreatePlayList extends StatelessWidget {
  const DlialogCreatePlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayListCubit, PlayListState>(
      builder: (context, state) {
        return Dialog(
            backgroundColor: Constans.navyblueshade2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Give your playlist a name.",
                      style: context.textTheme.subtitle1),
                  const MEdit(
                    hint: "",
                    autoFocus: false,
                    password: false,
                    notempty: true,
                  ),
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
                            //    print(_namePlayListContoroller.text);
                            state is CreatePlayList;
                            return context.playListCubit.createPlayList(
                                _namePlayListContoroller.text.toString(),
                                _namePlayListContoroller.text.toString(),
                                _namePlayListContoroller.text.toString(),
                                context);
                          },
                          child: Text("Skip",
                              style: context.textTheme.button!
                                  .copyWith(color: Colors.white)))
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
