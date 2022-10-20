import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/recentlyplayed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

class recentlyPlayed extends StatefulWidget {
  const recentlyPlayed({super.key});

  @override
  State<recentlyPlayed> createState() => _recentlyPlayedState();
}

class _recentlyPlayedState extends State<recentlyPlayed> {
  AssetsAudioPlayer player = AssetsAudioPlayer();
  @override
  Widget build(BuildContext context) {
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
    );
  }

  Recentlist() {
    return ValueListenableBuilder<Box<RecentPlayed>>(
        valueListenable: recentlyplayedbox.listenable(),
        builder: (context, Box<RecentPlayed> recentsongs, _) {
          List<RecentPlayed> rsongs = recentsongs.values.toList();

          if (rsongs.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  "No Songs Added",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(color: Colors.white)),
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
                return ListTile(
                  /* onTap: () {
                    player.open(Playlist(audios: , startIndex: index),
                        showNotification: true, loopMode: LoopMode.playlist);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => playingNow(),
                    ));
                    /* Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => playingNow()))); */
                  }, */
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