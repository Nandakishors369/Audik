// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/playlistmodel.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:audik_app/View/other%20screens/screenplayingnow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenPlaylist extends StatefulWidget {
  ScreenPlaylist(
      {super.key,
      required this.allPlaylistSongs,
      required this.playlistindex,
      required this.playlistname});

  List<Songs> allPlaylistSongs = [];
  int playlistindex;
  String playlistname;

  @override
  State<ScreenPlaylist> createState() => _ScreenPlaylistState();
}

class _ScreenPlaylistState extends State<ScreenPlaylist> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  List<Audio> plstsongs = [];

  @override
  void initState() {
    for (var song in widget.allPlaylistSongs) {
      plstsongs.add(Audio.file(song.songurl.toString(),
          metas: Metas(
              title: song.songname,
              artist: song.artist,
              id: song.id.toString())));
    }
    super.initState();
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
                height: 370,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/Music Brand and App Logo (1).png",
                      height: 280,
                      width: 280,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.playlistname,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                          ),
                          /*  Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: FloatingActionButton(
                              onPressed: () {
                                if (playlistbox.values.isEmpty) {}
                                player.open(
                                    Playlist(audios: plstsongs, startIndex: 0),
                                    showNotification: true,
                                    loopMode: LoopMode.playlist);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => playingNow(),
                                ));
                                /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => playingNow()))); */
                              },
                              child: Icon(Icons.play_arrow),
                            ),
                          )
 */
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
                  ],
                ),
              ),
              favoriteList()
            ],
          ),
        ),
      ),
    );
  }

  favoriteList() {
    return ValueListenableBuilder<Box<PlaylistSongs>>(
        valueListenable: playlistbox.listenable(),
        builder: (context, value, _) {
          List<PlaylistSongs> plsongs = playlistbox.values.toList();
          List<Songs>? songs = plsongs[widget.playlistindex].playlistssongs;
          if (songs!.isEmpty) {
            return Align(
              heightFactor: 7.5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "No Songs Added",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
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
              itemCount: songs.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  onTap: () {
                    player.open(Playlist(audios: plstsongs, startIndex: index),
                        showNotification: true, loopMode: LoopMode.playlist);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const playingNow(),
                    ));
                    /* Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => playingNow()))); */
                  },
                  leading: QueryArtworkWidget(
                    artworkFit: BoxFit.cover,
                    id: songs[index].id!,
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
                      songs[index].songname!,
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
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Delete Playlist"),
                            content: const Text("Are You Sure"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      songs.removeAt(index);
                                      plsongs.removeAt(index);
                                      playlistbox.putAt(
                                          widget.playlistindex,
                                          PlaylistSongs(
                                              playlistname: widget.playlistname,
                                              playlistssongs: songs));
                                    });
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Delete"))
                            ],
                          );
                        },
                      );
                    }),
                    icon: const Icon(
                      Icons.delete,
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
