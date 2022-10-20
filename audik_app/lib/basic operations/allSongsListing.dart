import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/mostlyplayed_model.dart';
import 'package:audik_app/Model/recentlyplayed_model.dart';
import 'package:audik_app/Playlist/createPlaylist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Favorite/addtofavorite.dart';
import '../Main Screens/splash.dart';
import '../Model/songModel.dart';
import '../Playlist/songtoplaylist.dart';
import '../other screens/screenplayingnow.dart';

class allSongsScreen extends StatefulWidget {
  const allSongsScreen({super.key});

  @override
  State<allSongsScreen> createState() => _allSongsScreenState();
}

class _allSongsScreenState extends State<allSongsScreen> {
  late bool isplaying;
  late bool playerVisibility;
  final box = SongBox.getInstance();
  List<Audio> convertAudios = [];
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');
  @override
  void initState() {
    List<Songs> dbSongs = box.values.toList();

    for (var item in dbSongs) {
      convertAudios.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<Box<Songs>>(
        valueListenable: box.listenable(),
        builder: (context, Box<Songs> allsongbox, child) {
          List<Songs> allDbSongs = allsongbox.values.toList();
          List<MostPlayed> allmostplayedsongs = mostplayedsongs.values.toList();
          //----------------------------------------If songs are not there--------------------------------------------------
          if (allDbSongs.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          //----------------------------------------If the list is null--------------------------------------------------
          if (allDbSongs == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //----------------------------------------Showing songs in list tile--------------------------------------------------
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10, //allDbSongs.length,
              itemBuilder: (context, index) {
                Songs songs = allDbSongs[index];
                RecentPlayed rsongs;
                MostPlayed MPsongs = allmostplayedsongs[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                  child: ListTile(
                    onTap: (() {
                      rsongs = RecentPlayed(
                          songname: songs.songname,
                          artist: songs.artist,
                          id: songs.id,
                          duration: songs.duration,
                          songurl: songs.songurl);
                      updateRecentPlayed(rsongs);
                      //updatePlayedSongCount(MPsongs, index);
                      /* updatePlayedSongCount(MPsongs, index); */
                      _audioPlayer.open(
                          Playlist(audios: convertAudios, startIndex: index),
                          showNotification: true,
                          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                          loopMode: LoopMode.playlist);
                      setState(() {});
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
                      id: songs.id!,
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
                        songs.songname!,
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
                              height: height * 0.13,
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
                  ),
                );
              });
        });
  }
}
