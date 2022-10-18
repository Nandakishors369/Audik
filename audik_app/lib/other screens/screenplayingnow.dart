import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

class playingNow extends StatefulWidget {
  const playingNow({super.key});

  @override
  State<playingNow> createState() => _playingNowState();
}

class _playingNowState extends State<playingNow> {
  final player = AssetsAudioPlayer.withId('0');
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isplaying = true;
  late String head;
  void initState() {
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

  @override
  void dispose() {
    print("helloooooo");
    // TODO: implement dispose
    super.dispose();
    player.stop();
  }

  void PlayPauseButton() async {
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 21, 21),
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
                          icon: Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 45,
                      ),
                      SizedBox(
                        width: 45,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/Music Brand and App Logo (1).png",
                  /* width: 320,
                  height: 320,
                  fit: BoxFit.fill, */
                  fit: BoxFit.contain,
                  height: 320,
                  width: 320,
                ),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        player.getCurrentAudioTitle,
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
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
                          timeLabelTextStyle: TextStyle(color: Colors.white),
                          onSeek: (duration) => player.seek(duration),
                        );
                      }),
                ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await player.previous();
                          if (isplaying == false) {
                            player.pause();
                          }
                        },
                        icon: Icon(Icons.skip_previous),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () async {
                          await player.seekBy(Duration(seconds: -10));
                        },
                        icon: Icon(Icons.replay_10),
                        color: Colors.white,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              PlayPauseButton();
                            },
                            icon: Icon((isplaying == true)
                                ? Icons.pause
                                : Icons.play_arrow),
                            iconSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await player.seekBy(Duration(seconds: 10));
                        },
                        icon: Icon(Icons.forward_10),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () async {
                          await player.next();
                          if (isplaying == false) {
                            player.pause();
                          }
                        },
                        icon: Icon(Icons.skip_next),
                        color: Colors.white,
                      ),
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
                          icon: Icon(
                            Icons.loop_sharp,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 45,
                      ),
                      SizedBox(
                        width: 45,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.shuffle),
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
  }
}
