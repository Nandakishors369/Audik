// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/favoriteModel.dart';
import 'package:audik_app/View/other%20screens/screenplayingnow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenFavorite extends StatelessWidget {
  ScreenFavorite({super.key});

  List<Audio> allsongs = [];

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                      "Favorites",
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
            ValueListenableBuilder<Box<favSongs>>(
                valueListenable: Hive.box<favSongs>('favsongs').listenable(),
                builder: (context, Box<favSongs> alldbfavsongs, child) {
                  List<favSongs> allDbSongs = alldbfavsongs.values.toList();
                  //----------------------------------------If songs are not there--------------------------------------------------
                  if (favsongsdb.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                        heightFactor: 7.5,
                        child: Center(
                            child: Text(
                          'No Favorites',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                      ),
                    );
                  }
                  //----------------------------------------If the list is null--------------------------------------------------
                  if (favsongsdb == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  //----------------------------------------Showing songs in list tile--------------------------------------------------
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allDbSongs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                          child: ListTile(
                              onTap: (() {
                                onplay();
                                audioPlayer.open(
                                    Playlist(
                                        audios: allsongs, startIndex: index),
                                    showNotification: true,
                                    headPhoneStrategy:
                                        HeadPhoneStrategy.pauseOnUnplug,
                                    loopMode: LoopMode.playlist);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => playingNow()),
                                  ),
                                );
                              }),
                              //----------------------------------------Displaying The Song Image--------------------------------------------------
                              leading: QueryArtworkWidget(
                                artworkFit: BoxFit.cover,
                                id: allDbSongs[index].id!,
                                type: ArtworkType.AUDIO,
                                artworkQuality: FilterQuality.high,
                                size: 2000,
                                quality: 100,
                                artworkBorder: BorderRadius.circular(50),
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  child: Image.asset(
                                    'assets/Music Brand and App Logo (1).png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: SingleChildScrollView(
                                child: Text(
                                  allDbSongs[index].songname!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontSize: 13.43,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Remove from favorites"),
                                          content: const Text("Are You Sure ?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel")),
                                            TextButton(
                                                onPressed: () {
                                                  favsongsdb.deleteAt(index);

                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Remove"))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.heart_broken,
                                    color: Colors.white,
                                  ))),
                        );
                      });
                })
          ],
        ),
      )),
    );
  }

  onplay() {
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
