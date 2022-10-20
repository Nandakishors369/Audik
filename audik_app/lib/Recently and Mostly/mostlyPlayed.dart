import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/mostlyplayed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Favorite/addtofavorite.dart';
import '../Playlist/createPlaylist.dart';
import '../other screens/screenplayingnow.dart';

class mostlyPlayed extends StatefulWidget {
  const mostlyPlayed({super.key});

  @override
  State<mostlyPlayed> createState() => _mostlyPlayedState();
}

class _mostlyPlayedState extends State<mostlyPlayed> {
  AssetsAudioPlayer player = AssetsAudioPlayer();
  List<Audio> songs = [];
  @override
  void initState() {
    // TODO: implement initState
    List<MostPlayed> songlist = mostplayedsongs.values.toList();
    for (var items in songlist) {
      songs.add(Audio.file(items.songurl,
          metas: Metas(
              title: items.songname,
              artist: items.artist,
              id: items.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getMostPlayed();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      body: SafeArea(
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
                      "Mostly Played",
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
          ],
        ),
      ),
    );
  }

  int getMostPlayed() {
    List<MostPlayed> songs = mostplayedsongs.values.toList();
    int large = 0;
    for (int i = 0; i < songs.length - 1; i++) {
      for (int j = 0; j < songs.length; j++) {
        if (songs[i].count < songs[j].count) {
          large = j;
        }
      }
    }
    return large;
  }

  showmostlyplayed() {
    return ValueListenableBuilder(
        valueListenable: mostplayedsongs.listenable(),
        builder: (context, Box<MostPlayed> mpsongbox, child) {
          List<MostPlayed> msSongs = mpsongbox.values.toList();
          int index1 = getMostPlayed();

          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: msSongs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                  child: ListTile(
                    onTap: (() {
                      print(player.getCurrentAudioTitle);

                      player.open(Playlist(audios: songs, startIndex: index1),
                          showNotification: true,
                          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                          loopMode: LoopMode.playlist);
                      setState(() {
                        //playerVisibility = true;
                      });
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
                      id: msSongs[index1].id,
                      type: ArtworkType.AUDIO,
                      artworkQuality: FilterQuality.high,
                      size: 2000,
                      quality: 100,
                      artworkBorder: BorderRadius.circular(50),
                      nullArtworkWidget: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: Image.asset(
                          'assets/Music Brand and App Logo (1).png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: SingleChildScrollView(
                      child: Text(
                        msSongs[index1].songname,
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
                      onPressed: (() {
                        showModalBottomSheet(
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: ((context) {
                            return SizedBox(
                              height: 200,
                              child: Column(
                                children: [
                                  AddToPlalistbutton(songindex: index1),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  addToFavorite(
                                    index: index1,
                                  )
                                  /* TextButton(
                                        onPressed: () {},
                                        child: const Text("Add to Favorites")) */
                                ],
                              ),
                            );
                          }),
                        );
                      }),
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
