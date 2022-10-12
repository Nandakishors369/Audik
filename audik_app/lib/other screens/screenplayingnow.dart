/* import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_manager/audio_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class playingNow extends StatefulWidget {
  const playingNow({super.key});

  @override
  State<playingNow> createState() => _playingNowState();
}

class _playingNowState extends State<playingNow> {
  //----------------------------------------Initialising Audio Player --------------------------------------------------

  final audioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

   @override
  void initState() async {
    super.initState();
   assetsAudioPlayer.open(
    Audio("assets/audios/song1.mp3"),
);
  } 

 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      body: SafeArea(
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
                      /* IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  )),
                   */
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Image.asset(
                "assets/Music Brand and App Logo (1).png",
                width: 320,
                height: 320,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "Name of the song",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
              SizedBox(
                height: 4,
              ),
              Slider(
                  value: position.inSeconds.toDouble(),
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: ((value) async {})),
              Text(""),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatTime(position)),
                    Text(formatTime(duration - position))
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                  ),
                  IconButton(
                      onPressed: (() {}),
                      icon: Icon(
                        Icons.fast_rewind,
                        size: 40,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 50,
                  ),
                  CircleAvatar(
                    radius: 35,
                    child: IconButton(
                      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                      iconSize: 50,
                      onPressed: () async {
                        if (isPlaying) {
                          await audioPlayer.pause();
                        } else {
                          String assts = 'assets/Ruth-B-Dandelions.mp3';
                          await audioPlayer
                              .play("assets/Ruth-B-Dandelions.mp3");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  IconButton(
                      onPressed: (() {}),
                      icon: Icon(
                        Icons.fast_forward,
                        size: 40,
                        color: Colors.white,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
/* Image.asset(
            "assets/Music Brand and App Logo (1).png",
            width: 320,
            height: 320,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            "Name of the song",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ),
          SizedBox(
            height: 4,
          ),
          Text(""),
          Slider(
              activeColor: Color.fromARGB(47, 158, 158, 158),
              inactiveColor: Colors.grey,
              thumbColor: Colors.blue,
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: ((value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);

                // if paused to start playing
                await audioPlayer.seek(position);
              })),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("0:00",
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(color: Colors.white))),
                Text("0:00",
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(color: Colors.white)))
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 80,
              ),
              IconButton(
                  onPressed: (() {}),
                  icon: Icon(
                    Icons.fast_rewind,
                    size: 40,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 50,
              ),
              CircleAvatar(
                radius: 35,
                child: IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    iconSize: 45,
                    onPressed: (() async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                      } /* else {
                        await audioPlayer.play(Url)
                      } */
                    })),
              ),
              SizedBox(
                width: 50,
              ),
              IconButton(
                  onPressed: (() {}),
                  icon: Icon(
                    Icons.fast_forward,
                    size: 40,
                    color: Colors.white,
                  )),
            ],
          ) */ */

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class playingNow extends StatefulWidget {
  const playingNow({super.key});

  @override
  State<playingNow> createState() => _playingNowState();
}

class _playingNowState extends State<playingNow> {
  final player = AssetsAudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isplaying = true;
  void initState() {
    super.initState();
    player.open(
        Playlist(audios: [
          Audio("assets/Ruth-B-Dandelions.mp3"),
          Audio('assets/Rosa_Linn_-_SNAP_9jaBam.com.mp3')
        ]),
        showNotification: true);
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
                SizedBox(
                  height: 70,
                ),
                Image.asset(
                  "assets/Music Brand and App Logo (1).png",
                  width: 320,
                  height: 320,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Row(
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
                      Text(
                        "Name of the song",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
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
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Slider(value: 0, onChanged: (value) {}),
                ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatTime(position),
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        formatTime(position),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await player.previous();
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
                        },
                        icon: Icon(Icons.skip_next),
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

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);

    final minutes = twoDigits(duration.inMinutes.remainder(60));

    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
