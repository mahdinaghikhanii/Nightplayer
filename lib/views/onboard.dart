import 'package:flutter/material.dart';
import 'package:nightplayer/module/constans.dart';
import 'package:nightplayer/module/extention.dart';
import 'package:nightplayer/views/home.dart';

import '../bloc/audio_bloc/audio_state.dart';

class OnBoard extends StatelessWidget {
  final AudioState stateaudio;
  const OnBoard({Key? key, required this.stateaudio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: Stack(
        children: [
          const FadeInImage(
            //      placeholder: AssetImage("assets/images/blackdot.png"),
            image: AssetImage("assets/img/onboardimg.jpg"),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            //if you use a larger image, you can set where in the image you like most
            //width alignment.centerRight, bottomCenter, topRight, etc...
            alignment: Alignment.center,
            placeholder: AssetImage("assets/img/onboardimg.jpg"),
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
                  onTap: () => context.nextPage(Home(stateaudio: stateaudio)),
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
