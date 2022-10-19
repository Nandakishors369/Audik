import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Favorite/addtofavorite.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/favoriteModel.dart';
import 'package:audik_app/Playlist/songtoplaylist.dart';
import 'package:audik_app/other%20screens/screenplayingnow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenFavorite extends StatefulWidget {
  const ScreenFavorite({super.key});

  @override
  State<ScreenFavorite> createState() => _ScreenFavoriteState();
}

class _ScreenFavoriteState extends State<ScreenFavorite> {
  List<Audio> allsongs = [];
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  @override
  void initState() {
    // TODO: implement initState
    final favSongsdb = Hive.box<favSongs>('favsongs').values.toList();
    for (var item in favSongsdb) {
      allsongs.add(Audio.file(item.songurl.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 21, 21),
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
                      "Favorites",
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: FloatingActionButton(
                        onPressed: () {
                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => playingNow()))); */
                        },
                        child: Icon(Icons.play_arrow),
                      ),
                    ) */
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
                      child: Center(
                          child: Text(
                        'No Favorites',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
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
                                audioPlayer.open(
                                    Playlist(
                                        audios: allsongs, startIndex: index),
                                    showNotification: true,
                                    headPhoneStrategy:
                                        HeadPhoneStrategy.pauseOnUnplug,
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
                                    favsongsdb.deleteAt(index);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.blue,
                                  ))),
                        );
                      });
                })
          ],
        ),
      )),
    );
  }
}
