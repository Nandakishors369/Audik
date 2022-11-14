// ignore_for_file: file_names, camel_case_types, unused_local_variable, non_constant_identifier_names

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Favorite/addtofavorite.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/recentlyplayed_model.dart';
import 'package:audik_app/Playlist/createPlaylist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Model/mostlyplayed_model.dart';

class recentlyPlayed extends StatefulWidget {
  const recentlyPlayed({super.key});

  @override
  State<recentlyPlayed> createState() => _recentlyPlayedState();
}

class _recentlyPlayedState extends State<recentlyPlayed> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  List<Audio> resongs = [];

  @override
  void initState() {
   
    List<RecentPlayed> rdbsongs =
        recentlyplayedbox.values.toList().reversed.toList();
    for (var item in rdbsongs) {
      resongs.add(Audio.file(item.songurl!,
          metas: Metas(
            artist: item.songname,
            title: item.artist,
            id: item.id.toString(),
          )));
    }
    super.initState();
  }

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
                        "Recently Played",
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
              Recentlist()
            ],
          ),
        ),
      ),
    );
  }

  Recentlist() {
    return ValueListenableBuilder<Box<RecentPlayed>>(
        valueListenable: recentlyplayedbox.listenable(),
        builder: (context, Box<RecentPlayed> recentsongs, _) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          List<RecentPlayed> rsongs =
              recentsongs.values.toList().reversed.toList();

          if (rsongs.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                heightFactor: 7.5,
                child: Center(
                  child: Text(
                    "You haven't played anything ! Try playing something.",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: rsongs.length,
              itemBuilder: ((context, index) {
                List<MostPlayed> allmostplayedsongs =
                    mostplayedsongs.values.toList();
                MostPlayed msongs = allmostplayedsongs[index];
                return ListTile(
                  onTap: () {
                    /* final rsong = RecentPlayed(
                        songname: rsongs[index].songname,
                        artist: rsongs[index].artist,
                        duration: rsongs[index].duration,
                        songurl: rsongs[index].songurl,
                        id: rsongs[index].id);

                    updatePlayedSongCount(msongs, index);
                    //updateRecentPlayed(rsong, index); */
                    /* player.open(
                      Playlist(audios: resongs, startIndex: index),
                      showNotification: true,
                      loopMode: LoopMode.playlist,
                    );
                    setState(() {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => playingNow()),
                      ),
                    ); */
                  },
                  leading: QueryArtworkWidget(
                    artworkFit: BoxFit.cover,
                    id: rsongs[index].id!,
                    type: ArtworkType.AUDIO,
                    artworkQuality: FilterQuality.high,
                    size: 2000,
                    quality: 100,
                    artworkBorder: BorderRadius.circular(50),
                    nullArtworkWidget: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Image.asset(
                        'assets/Music Brand and App Logo (1).png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: SingleChildScrollView(
                    child: Text(
                      rsongs[index].songname!,
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
                            height: 130 /* height * 0.13 */,
                            child: Column(
                              children: [
                                AddToPlalistbutton(songindex: index),
                                SizedBox(
                                  height: height * 0.011,
                                ),
                                addToFavorite(
                                  index: index,
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
                );
              }),
            ),
          );
        });
  }
}

/* class RecentlyPlayedScreen extends StatelessWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Box<RecentPlayed>>(
          valueListenable: recentlyplayedbox.listenable(),
          builder: (context, Box<RecentPlayed> recentsongs, _) {
            List<RecentPlayed> rsongs = recentsongs.values.toList();

            if (rsongs.isEmpty) {
              return Center(
                  child: Text(
                'No Recently played',
                style: TextStyle(color: Colors.white),
              ));
            }
            return ListView.builder(
              padding: EdgeInsets.only(top: 10, bottom: 0),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return recentsongs.isEmpty
                    ? Center(
                        child: Text(
                        'No Recent Played !',
                        style: TextStyle(color: Colors.white),
                      ))
                    : ListTile(
                        leading: QueryArtworkWidget(
                          artworkBorder: BorderRadius.circular(15),
                          artworkHeight: 90,
                          artworkWidth: 60,
                          id: rsongs[index].id!,
                          type: ArtworkType.AUDIO,
                          artworkFit: BoxFit.cover,
                          nullArtworkWidget: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/images/music.png',
                                width: 60,
                                height: 90,
                                fit: BoxFit.cover,
                              )),
                        ),
                        title: Text(
                          rsongs[index].songname!,
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          rsongs[index].artist!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                        // trailing: favPlayListIcons(),
                      );
              },
              itemCount: rsongs.length > 5 ? 5 : rsongs.length,
            );
          }),
    );
  }
}
 */
