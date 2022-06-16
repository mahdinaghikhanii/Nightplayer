import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc/statebloc.dart';
import '../module/constans.dart';
import '../module/extention.dart';
import '../module/widgets.dart';

class Home extends StatefulWidget {
  final StateBloc stateBloc;
  const Home({Key? key, required this.stateBloc}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> songs = [];
  String currentSongTitle = '';
  int currentIndex = 0;

  bool isPlayerViewVisible = false;

  void _changePlayerViewVisibility() {
    setState(() {
      isPlayerViewVisible = !isPlayerViewVisible;
    });
  }

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          _player.positionStream,
          _player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));

  final AudioPlayer _player = AudioPlayer();
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  void initState() {
    super.initState();
    requestStoragePermission();

    //update the current playing song index listener
    _player.currentIndexStream.listen((index) {
      if (index != null) {
        _updateCurrentPlayingSongDetails(index);
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isPlayerViewVisible) {
      return Scaffold(
        //backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 56.0, right: 20.0, left: 20.0),
            //  decoration: BoxDecoration(color: bgColor),
            child: Column(
              children: <Widget>[
                //exit button and the song title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap:
                            _changePlayerViewVisibility, //hides the player view
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: getDecoration(
                              BoxShape.circle, const Offset(2, 2), 2.0, 0.0),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        currentSongTitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      flex: 5,
                    ),
                  ],
                ),

                //artwork container
                Container(
                  width: 300,
                  height: 300,
                  decoration: getDecoration(
                      BoxShape.circle, const Offset(2, 2), 2.0, 0.0),
                  margin: const EdgeInsets.only(top: 30, bottom: 30),
                  child: QueryArtworkWidget(
                    id: songs[currentIndex].id,
                    type: ArtworkType.AUDIO,
                    artworkBorder: BorderRadius.circular(200.0),
                  ),
                ),

                //slider , position and duration widgets
                Column(
                  children: [
                    //slider bar container
                    Container(
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(bottom: 4.0),
                      //  decoration: getRectDecoration(BorderRadius.circular(20.0), const Offset(2, 2), 2.0, 0.0),

                      //slider bar duration state stream
                      child: StreamBuilder<DurationState>(
                        stream: _durationStateStream,
                        builder: (context, snapshot) {
                          final durationState = snapshot.data;
                          final progress =
                              durationState?.position ?? Duration.zero;
                          final total = durationState?.total ?? Duration.zero;

                          return ProgressBar(
                            progress: progress,
                            total: total,
                            barHeight: 20.0,
                            //   baseBarColor: bgColor,
                            progressBarColor: const Color(0xEE9E9E9E),
                            thumbColor: Colors.white60.withBlue(99),
                            timeLabelTextStyle: const TextStyle(
                              fontSize: 0,
                            ),
                            onSeek: (duration) {
                              _player.seek(duration);
                            },
                          );
                        },
                      ),
                    ),

                    //position /progress and total text
                    StreamBuilder<DurationState>(
                      stream: _durationStateStream,
                      builder: (context, snapshot) {
                        final durationState = snapshot.data;
                        final progress =
                            durationState?.position ?? Duration.zero;
                        final total = durationState?.total ?? Duration.zero;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Text(
                                progress.toString().split(".")[0],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                total.toString().split(".")[0],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),

                //prev, play/pause & seek next control buttons
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //skip to previous
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            if (_player.hasPrevious) {
                              _player.seekToPrevious();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: getDecoration(
                                BoxShape.circle, const Offset(2, 2), 2.0, 0.0),
                            child: const Icon(
                              Icons.skip_previous,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),

                      //play pause
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            if (_player.playing) {
                              _player.pause();
                            } else {
                              if (_player.currentIndex != null) {
                                _player.play();
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            margin:
                                const EdgeInsets.only(right: 20.0, left: 20.0),
                            decoration: getDecoration(
                                BoxShape.circle, const Offset(2, 2), 2.0, 0.0),
                            child: StreamBuilder<bool>(
                              stream: _player.playingStream,
                              builder: (context, snapshot) {
                                bool? playingState = snapshot.data;
                                if (playingState != null && playingState) {
                                  return const Icon(
                                    Icons.pause,
                                    size: 30,
                                    color: Colors.white70,
                                  );
                                }
                                return const Icon(
                                  Icons.play_arrow,
                                  size: 30,
                                  color: Colors.white70,
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      //skip to next
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            if (_player.hasNext) {
                              _player.seekToNext();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: getDecoration(
                                BoxShape.circle, const Offset(2, 2), 2.0, 0.0),
                            child: const Icon(
                              Icons.skip_next,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //go to playlist, shuffle , repeat all and repeat one control buttons
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //go to playlist btn
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            _changePlayerViewVisibility();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: getDecoration(
                                BoxShape.circle, const Offset(2, 2), 2.0, 0.0),
                            child: const Icon(
                              Icons.list_alt,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),

                      //shuffle playlist
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            _player.setShuffleModeEnabled(true);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            margin:
                                const EdgeInsets.only(right: 30.0, left: 30.0),
                            decoration: getDecoration(
                                BoxShape.circle, const Offset(2, 2), 2.0, 0.0),
                            child: const Icon(
                              Icons.shuffle,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),

                      //repeat mode
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            _player.loopMode == LoopMode.one
                                ? _player.setLoopMode(LoopMode.all)
                                : _player.setLoopMode(LoopMode.one);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: getDecoration(
                                BoxShape.circle, const Offset(2, 2), 2.0, 0.0),
                            child: StreamBuilder<LoopMode>(
                              stream: _player.loopModeStream,
                              builder: (context, snapshot) {
                                final loopMode = snapshot.data;
                                if (LoopMode.one == loopMode) {
                                  return const Icon(
                                    Icons.repeat_one,
                                    color: Colors.white70,
                                  );
                                }
                                return const Icon(
                                  Icons.repeat,
                                  color: Colors.white70,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      // bottomNavigationBar: const MBottomNavigation(),
      appBar: AppBar(
        backgroundColor: Constans.kdefultAppColor,
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        elevation: 0,
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constans.kdefualtAppPading),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.search,
                  size: 26,
                )),
          )
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constans.kdefualtAppPading),
          child: Text(
            'NightPlayer',
            style: context.textTheme.subtitle1!.copyWith(fontSize: 22),
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: Constans.kdefualtAppPading),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const MSmallListTile(
              text: "All Song",
            ),
            Expanded(
                child: FutureBuilder<List<SongModel>>(
                    future: audioQuery.querySongs(
                      sortType: null,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true,
                    ),
                    builder: (context, iteam) {
                      if (iteam.data == null) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }

                      if (iteam.data!.isEmpty) {
                        return Center(
                            child: Text(
                          'No song found',
                          style: context.textTheme.subtitle1,
                        ));
                      }
                      songs.clear();
                      songs = iteam.data!;
                      return ListView.builder(
                          itemCount: iteam.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              height: 68,
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () async {
                                  _changePlayerViewVisibility();

                                  // Try to load audio from a source and catch any errors.
                                  //  String? uri = item.data![index].uri;
                                  // await _player.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
                                  await _player.setAudioSource(
                                      createPlaylist(iteam.data!),
                                      initialIndex: index);
                                  await _player.play();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                        QueryArtworkWidget(
                                            nullArtworkWidget: Image.asset(
                                              'assets/icon/song248.png',
                                              width: 65,
                                              height: 65,
                                              fit: BoxFit.fill,
                                            ),
                                            artworkBorder:
                                                BorderRadius.circular(10),
                                            artworkWidth: 65,
                                            artworkHeight: 65,
                                            id: iteam.data![index].id,
                                            type: ArtworkType.AUDIO),
                                        const SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 10),
                                            Expanded(
                                              child: SizedBox(
                                                width: 180,
                                                height: 24,
                                                child: Text(
                                                  iteam.data![index].title,
                                                  overflow: TextOverflow.fade,
                                                  style: context
                                                      .textTheme.subtitle1!
                                                      .copyWith(fontSize: 16),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Expanded(
                                              child: SizedBox(
                                                width: 180,
                                                height: 24,
                                                child: Text(
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    overflow: TextOverflow.clip,
                                                    iteam.data![index].artist ??
                                                        "No Artist",
                                                    style: context
                                                        .textTheme.subtitle1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        IconButton(
                                            onPressed: (() {}),
                                            icon: Icon(
                                              Icons.more_horiz,
                                              size: 35,
                                              color: Constans.kwhite,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }))
          ],
        ),
      ),
    );
  }

  void requestStoragePermission() async {
    //only if the platform is not web, coz web have no permissions
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }

      //ensure build method is called
      setState(() {});
    }
  }

  //create playlist
  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(AudioSource.uri(Uri.parse(song.uri!)));
    }
    return ConcatenatingAudioSource(children: sources);
  }

  //update playing song details
  void _updateCurrentPlayingSongDetails(int index) {
    setState(() {
      if (songs.isNotEmpty) {
        currentSongTitle = songs[index].title;
        currentIndex = index;
      }
    });
  }
}

BoxDecoration getDecoration(
    BoxShape shape, Offset offset, double blurRadius, double spreadRadius) {
  return BoxDecoration(
    color: Colors.red,
    shape: shape,
    boxShadow: [
      BoxShadow(
        offset: -offset,
        color: Colors.white24,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        offset: offset,
        color: Colors.black,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      )
    ],
  );
}

class DurationState {
  DurationState({this.position, this.total});
  Duration? position, total;
}
