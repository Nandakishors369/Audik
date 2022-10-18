// ignore_for_file: camel_case_types

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class playingNow extends StatefulWidget {
  const playingNow({super.key});

  @override
  State<playingNow> createState() => _playingNowState();
}

class _playingNowState extends State<playingNow> {
  final player = AssetsAudioPlayer.withId('0');
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  /* bool isplaying = true; */

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    print("kitiii");
    print(player.getCurrentAudioTitle);
    setState(() {});
  }

  @override
  void dispose() {
    print("helloooooo");
    // TODO: implement dispose
    super.dispose();
    player.stop();
  }

  /* void PlayPauseButton() async {
    if (isplaying == true) {
      await player.pause();
      setState(() {
        isplaying = false;
      });
    } else if (isplaying == false) {
      await player.play();
      setState(() {
        isplaying = true;
      });
    }
  }
 */
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return player.builderCurrent(builder: (context, playing) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        body: SafeArea(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Now Playing",
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                            )),
                        const SizedBox(
                          width: 45,
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 320,
                    width: 320,
                    child: QueryArtworkWidget(
                      artworkFit: BoxFit.contain,
                      artworkBorder: BorderRadius.circular(8),
                      artworkHeight: 320,
                      artworkWidth: 320,
                      id: int.parse(playing.audio.audio.metas.id!),
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/Music Brand and App Logo (1).png',
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Column(
                      children: [
                        SizedBox(height: height * .02),
                        SizedBox(
                          height: height * .03,
                          width: width,
                          child: Marquee(
                            blankSpace: 20,
                            velocity: 20,
                            text: player.getCurrentAudioTitle,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ),
                        ),
                        SizedBox(
                          height: height * .03,
                          width: width * .2,
                          child: Marquee(
                            blankSpace: 20,
                            velocity: 20,
                            text: player.getCurrentAudioArtist,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: PlayerBuilder.realtimePlayingInfos(
                        player: player,
                        builder: (context, realtimePlayingInfos) {
                          final duration =
                              realtimePlayingInfos.current!.audio.duration;

                          final position = realtimePlayingInfos.currentPosition;
                          return ProgressBar(
                            progress: position,
                            total: duration,
                            timeLabelPadding: 15,
                            timeLabelTextStyle:
                                const TextStyle(color: Colors.white),
                            onSeek: (duration) => player.seek(duration),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PlayerBuilder.isPlaying(
                            player: player,
                            builder: (context, isPlaying) {
                              return IconButton(
                                onPressed: () async {
                                  await player.previous();
                                  setState(() {});
                                  if (isPlaying == false) {
                                    player.pause();
                                  }
                                },
                                icon: const Icon(Icons.skip_previous),
                                color: Colors.white,
                              );
                            }),
                        IconButton(
                          onPressed: () async {
                            await player.seekBy(const Duration(seconds: -10));
                          },
                          icon: const Icon(Icons.replay_10),
                          color: Colors.white,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: PlayerBuilder.isPlaying(
                                player: player,
                                builder: (context, isPlaying) {
                                  return IconButton(
                                    onPressed: () {
                                      player.playOrPause();
                                    },
                                    icon: Icon(isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow),
                                    iconSize: 40,
                                    color: Colors.white,
                                  );
                                }),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await player.seekBy(const Duration(seconds: 10));
                          },
                          icon: const Icon(Icons.forward_10),
                          color: Colors.white,
                        ),
                        PlayerBuilder.isPlaying(
                            player: player,
                            builder: (context, isPlaying) {
                              return IconButton(
                                onPressed: () async {
                                  await player.next();
                                  setState(() {});
                                  if (isPlaying == false) {
                                    player.pause();
                                  }
                                },
                                icon: const Icon(Icons.skip_next),
                                color: Colors.white,
                              );
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.loop_sharp,
                              color: Colors.white,
                            )),
                        const SizedBox(
                          width: 45,
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.shuffle),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
/* void initState() {
    super.initState();

    print("hi");

    player.open(
        Playlist(audios: [
          Audio("assets/Ruth-B-Dandelions.mp3",
              metas: Metas(
                title: "Dandelions - Ruth B.",
                artist: "Ruth B.",
              )),
          Audio('assets/Rosa_Linn_-_SNAP_9jaBam.com.mp3',
              metas: Metas(title: "SNAP - Rosa Linn", artist: "Rosa Linn")),
        ]),
        showNotification: true);

    print("done");

    setState(() {
      print("hmmmmmm");
      player.pause();
    });
    print("bye");
  }
 */