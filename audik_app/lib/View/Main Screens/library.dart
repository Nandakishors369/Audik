// ignore_for_file: unused_import, camel_case_types, unused_local_variable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/View/Playlist/addplaylist.dart';
import 'package:audik_app/View/Favorite/favorite.dart';
import 'package:audik_app/View/Playlist/libraryplaylistview.dart';
import 'package:audik_app/View/Playlist/playlistscreen.dart';
import 'package:audik_app/View/basic%20operations/songfromalbums.dart';
import 'package:audik_app/View/other%20screens/screenplayingnow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class librarySearch extends StatelessWidget {
  const librarySearch({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomSheet: playingCard(
          /* index: 0 */
          ),
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.096,
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
                      "My Library",
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
              height: height * 0.016,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const ScreenFavorite())));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  height: height * 0.064,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 0, 0, 0)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text("Favorite Tracks",
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                )),
                          ],
                        ),

                        /* SizedBox(
                          width: 190,
                        ), */
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.016,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const addPlaylist()))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    headings("Your Playlist"),
                    /*  SizedBox(
                      width: 265,
                    ), */
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            const playlistView(),
            const SizedBox(
                //height: height * 0.011,
                ),
            //headings("Folders"),
            const Album(width: 5),
            const SizedBox(height: 20)
          ],
        ),
      )),
    );
  }

  headings(String name) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 0, 4),
      child: Row(
        children: [
          Text(
            name,
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  //----------------------------------------Playlist--------------------------------------------------
  play(context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    String hello;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: SizedBox(
        height: 200,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            itemBuilder: ((context, index) {
              return playlistCard(context);
            }),
            separatorBuilder: ((context, index) {
              return const SizedBox(
                width: 10,
              );
            }),
            itemCount: 8),
      ),
    );
  }

  //----------------------------------------PlayList Card--------------------------------------------------
  playlistCard(context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        /* Navigator.push(context,
            MaterialPageRoute(builder: ((context) => ScreenPlaylist()))); */
      },
      child: Container(
        height: height * 0.011,
        // width: 132,
        color: const Color.fromARGB(0, 3, 128, 230),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/Music Brand and App Logo (1).png",
                  width: 132,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Name here",
              style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 13.43,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}

class playingCard extends StatefulWidget {
  /* int index; */
  const playingCard({
    super.key,
    /*  required this.index */
  });

  @override
  State<playingCard> createState() => _playingCardState();
}

class _playingCardState extends State<playingCard> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(builder: (context, playing) {
      return Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: ListTile(
          onTap: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => playingNow())));
          }),
          contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 10),
          leading: QueryArtworkWidget(
            id: int.parse(playing.audio.audio.metas.id!),
            type: ArtworkType.AUDIO,
            artworkWidth: 50,
            artworkHeight: 50,
            artworkFit: BoxFit.fill,
            nullArtworkWidget: ClipRect(
              child: Image.asset(
                "assets/Music Brand and App Logo (1).png",
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
          ),
          title: Marquee(
            text: player.getCurrentAudioTitle,
            style: const TextStyle(color: Colors.white),
            blankSpace: 80,
            pauseAfterRound: const Duration(seconds: 2),
          ),
          trailing: PlayerBuilder.isPlaying(
            player: player,
            builder: (context, isPlaying) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () async {
                        await player.previous();
                        setState(() {});
                        if (isPlaying == false) {
                          player.pause();
                        }
                      },
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                      )),
                  IconButton(
                    onPressed: () {
                      player.playOrPause();
                    },
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () async {
                      await player.next();
                      setState(() {});
                      if (isPlaying == false) {
                        player.pause();
                      }
                    },
                    icon: const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
