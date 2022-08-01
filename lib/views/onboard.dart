import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/onboard_bloc/onboard_cubit.dart';
import '../module/constans.dart';
import '../module/extention.dart';
import '../perfs/onboard_perfs.dart';
import 'home.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnBoardPerfs perfs = OnBoardPerfs();
    return Scaffold(
        body: SizedBox(
      child: Stack(
        children: [
          const FadeInImage(
            image: AssetImage("assets/img/onboardimg.jpg"),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            placeholder: AssetImage("assets/img/null.jpg"),
          ),
          Padding(
            padding: const EdgeInsets.all(Constans.kdefualtAppPading),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Nightplayer\n\n",
                          style: context.textTheme.subtitle1!.copyWith(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                          text:
                              "listen to your favorite musics\nAnywhere and anytime",
                          style: context.textTheme.subtitle1!.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )
                      ])),
                ),
                InkWell(
                  borderRadius:
                      BorderRadius.circular(Constans.kdefualtBorderRadios),
                  splashColor: Colors.white,
                  hoverColor: Colors.white,
                  onTap: () {
                    perfs.storeInBoardScreansInfo();
                    context.nextPage(const Home());
                    context.read<OnBoardCubit>().saveUserSeeOnBoard();
                  },
                  child: Container(
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            Constans.kdefualtBorderRadios),
                        color: Colors.white.withOpacity(0.3)),
                    child: Center(
                        child: Text(
                      'Listen music now',
                      style: context.textTheme.subtitle1!.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
