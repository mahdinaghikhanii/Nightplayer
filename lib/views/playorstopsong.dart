// ignore_for_file: unused_element

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../bloc/audio_bloc/audio_cubit.dart';
import '../bloc/audio_bloc/audio_state.dart';
import '../model/duration_state.dart';
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
      body: BlocBuilder<AudioCubit, AudioState>(
          builder: (BuildContext context, state) {
        return SafeArea(
          child: StreamBuilder<int?>(
            stream: context.audioCuibt.player.currentIndexStream,
            builder: (context, snapshot) {
              final currentIndex = snapshot.data;

              if (currentIndex != null) {
                return Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                          ),
                          child: QueryArtworkWidget(
                              nullArtworkWidget: Image.asset(
                                'assets/img/null.jpg',
                                fit: BoxFit.fill,
                              ),
                              artworkBorder: BorderRadius.circular(10),
                              artworkWidth: double.infinity,
                              //  artworkHeight: 65,
                              id: context
                                  .audioCuibt
                                  .selectedSongforPLay[context.audioCuibt.index]
                                  .id,
                              type: ArtworkType.AUDIO)),
                    ),
                    const SizedBox(height: 20),
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
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 30, right: 30),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      height: 24,
                                      child: Text(
                                        context
                                            .audioCuibt
                                            .selectedSongforPLay[
                                                context.audioCuibt.index]
                                            .title,
                                        style: context.textTheme.subtitle1!
                                            .copyWith(fontSize: 22),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 65,
                                      height: 65,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Text(
                                  context
                                      .audioCuibt
                                      .selectedSongforPLay[
                                          context.audioCuibt.index]
                                      .artist
                                      .toString(),
                                  style: context.textTheme.subtitle1!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              const SizedBox(height: 25),
                              Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container()),
                              const SizedBox(height: 15),
                              Container(
                                  padding: EdgeInsets.zero,
                                  margin: const EdgeInsets.only(
                                      bottom: 4, left: 30, right: 30),
                                  child: StreamBuilder<DurationState>(
                                      stream: context.audioCuibt.durationState,
                                      builder: (context, snapshot) {
                                        final positionDurationState =
                                            snapshot.data;
                                        final progres =
                                            positionDurationState?.position ??
                                                Duration.zero;
                                        final duration =
                                            positionDurationState?.duration ??
                                                Duration.zero;
                                        return ProgressBar(
                                          progress: progres,
                                          total: duration,
                                          baseBarColor: Colors.white,
                                          progressBarColor:
                                              const Color(0xFF6A1B9A),
                                          thumbColor: Colors.white10,
                                          thumbGlowColor:
                                              const Color(0xFF6A1B9A),
                                          timeLabelPadding: 10,
                                          timeLabelTextStyle:
                                              context.textTheme.subtitle1,
                                          onSeek: (duration) {
                                            context.audioCuibt.player
                                                .seek(duration);
                                          },
                                        );
                                      })),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  right: 30,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MButtonForSong(
                                      ontap: () {
                                        context.audioCuibt.backAudio();
                                      },
                                      icon: Icons.arrow_back_ios,
                                    ),
                                    const SizedBox(width: 20),
                                    MButtonForSong(
                                      ontap: () {
                                        state is Pause
                                            ? context.audioCuibt.resumeSong()
                                            : context.audioCuibt.pauseAudio();
                                      },
                                      icon: state is Pause
                                          ? Icons.play_arrow
                                          : state is Play
                                              ? Icons.pause
                                              : Icons.pause,
                                      boxColor: true,
                                    ),
                                    const SizedBox(width: 20),
                                    MButtonForSong(
                                      ontap: () {
                                        context.audioCuibt.nextAudio();
                                      },
                                      icon: Icons.arrow_forward_ios,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return const MWating();
            },
          ),
        );
      }),
    );
  }
}
