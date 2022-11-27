// ignore_for_file: camel_case_types

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Bloc/bloc/favorites_bloc.dart';
import 'package:audik_app/View/other%20screens/screenplayingnow.dart';
import 'package:audik_app/View/other%20screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../Model/dbfunctions.dart';
import '../../Model/favoriteModel.dart';

class favHome extends StatelessWidget {
  favHome({super.key});

  List<Audio> allsongs = [];

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
        ),
        BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            return ValueListenableBuilder<Box<favSongs>>(
                valueListenable: Hive.box<favSongs>('favsongs').listenable(),
                builder: (context, Box<favSongs> alldbfavsongs, child) {
                  List<favSongs> allDbSongs = alldbfavsongs.values.toList();
                  //----------------------------------------If songs are not there--------------------------------------------------
                  if (favsongsdb.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  //----------------------------------------If the list is null-----------------------------------------------------
                  if (favsongsdb == null) {}

                  //----------------------------------------Showing songs in list tile--------------------------------------------------
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              "Your Favorites",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: width * 0.0543,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          /*  height: height * 0.224, */
                          height: 220,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(19),
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () {
                                  /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const ScreenPlaylist()),
                            ),
                          ); */
                                },
                                child: GestureDetector(
                                  onTap: (() {
                                    audioPlayer.open(
                                        Playlist(
                                            audios: allsongs,
                                            startIndex: index),
                                        showNotification: musicNotif,
                                        headPhoneStrategy:
                                            HeadPhoneStrategy.pauseOnUnplug,
                                        loopMode: LoopMode.playlist);
                                    /*  setState(() {
                                      //playerVisibility = true;
                                    }); */
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => playingNow()),
                                      ),
                                    );
                                  }),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0, height * 0.0106, 0, 0),
                                        child: QueryArtworkWidget(
                                          artworkHeight: width * 0.306,
                                          artworkWidth: width * 0.306,
                                          artworkFit: BoxFit.cover,
                                          id: allDbSongs[index].id!,
                                          type: ArtworkType.AUDIO,
                                          artworkQuality: FilterQuality.high,
                                          size: 2000,
                                          quality: 100,
                                          artworkBorder:
                                              BorderRadius.circular(8),
                                          nullArtworkWidget: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            child: Image.asset(
                                              'assets/Music Brand and App Logo (1).png',
                                              height: width * 0.306,
                                              width: width * 0.306,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        height: 18,
                                        width: width * .28,
                                        child: Marquee(
                                          blankSpace: 20,
                                          velocity: 20,
                                          text: allDbSongs[index].songname!,
                                          style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                            separatorBuilder: ((context, index) {
                              return SizedBox(
                                width: width * 0.024,
                              );
                            }),
                            itemCount: allDbSongs.length,
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
      ],
    );
  }

  favhead(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (favsongsdb.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Row(
        children: [
          Text(
            "Your Favorites",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                  fontSize: width * 0.0543,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  AddSongsToAudio() {
    final favSongsdb = Hive.box<favSongs>('favsongs').values.toList();
    for (var item in favSongsdb) {
      allsongs.add(Audio.file(item.songurl.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
  }
}
