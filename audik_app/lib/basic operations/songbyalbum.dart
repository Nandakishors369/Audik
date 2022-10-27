import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Favorite/addtofavorite.dart';
import 'package:audik_app/Main%20Screens/home.dart';
import 'package:audik_app/Model/recentlyplayed_model.dart';
import 'package:audik_app/Playlist/createPlaylist.dart';
import 'package:audik_app/other%20screens/screenplayingnow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

import 'package:on_audio_query/on_audio_query.dart';

class SongsByAlbumScreen extends StatefulWidget {
  final String albumName;
  final int albumId;
  const SongsByAlbumScreen(
      {super.key, required this.albumName, required this.albumId});

  @override
  State<SongsByAlbumScreen> createState() => _SongsByAlbumScreenState();
}

class _SongsByAlbumScreenState extends State<SongsByAlbumScreen> {
  final OnAudioQuery fetchAlbumSongs = OnAudioQuery();
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');
  int itemId = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                      Expanded(
                        child: Marquee(
                          blankSpace: 40,
                          velocity: 40,
                          // pauseAfterRound: Duration(seconds: 2),
                          text: "${widget.albumName}   ",
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<List<SongModel>>(
                future: fetchAlbumSongs.queryAudiosFrom(
                    AudiosFromType.ALBUM_ID, widget.albumId,
                    sortType: SongSortType.TITLE,
                    orderType: OrderType.ASC_OR_SMALLER),
                builder: (context, item) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10),
                    itemBuilder: (context, index) {
                      List<Audio> songsByAlbums = [];
                      for (var songs in item.data!) {
                        itemId = songs.id;
                        songsByAlbums.add(Audio.file(songs.uri.toString(),
                            metas: Metas(
                                artist: songs.artist,
                                title: songs.title,
                                album: songs.album,
                                id: songs.id.toString())));
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                        child: ListTile(
                          onTap: (() {
                            /* rsongs = RecentPlayed(
                            songname: songs.songname,
                            album: songs.album,
                            id: songs.id,
                            duration: songs.duration,
                            songurl: songs.songurl);
                        updateRecentPlayed(rsongs, index);
                        updatePlayedSongCount(MPsongs, index);
                        /* updatePlayedSongCount(MPsongs, index); */ */
                            _audioPlayer.open(
                                Playlist(
                                    audios: songsByAlbums, startIndex: index),
                                showNotification: true,
                                headPhoneStrategy:
                                    HeadPhoneStrategy.pauseOnUnplug,
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
                            id: itemId,
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
                              songsByAlbums[index].metas.title.toString(),
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
                        ),
                      ); /* ListTile(
                    onTap: () {
                      _audioPlayer.open(
                        Playlist(audios: songsByAlbums, startIndex: index),
                        showNotification: true,
                      );
        
                      const homeScreen();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Text(
                                "hello"); /* (
                                  index: index,
                                ); */
                          },
                        ),
                      );
                    },
                    leading: QueryArtworkWidget(
                      artworkBorder: BorderRadius.circular(15),
                      artworkHeight: 90,
                      artworkWidth: 60,
                      id: itemId,
                      type: ArtworkType.AUDIO,
                      artworkFit: BoxFit.cover,
                      nullArtworkWidget: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/Music Brand and App Logo (1).png',
                            width: 60,
                            height: 90,
                            fit: BoxFit.cover,
                          )),
                    ),
                    title: Text(
                      songsByAlbums[index].metas.title.toString(),
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    subtitle: Text(
                      songsByAlbums[index].metas.album.toString(),
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      overflow: TextOverflow.ellipsis,
                    ),
                    // trailing: favPlayListIcons(),
                  ); */
                    },
                    itemCount: item.data!.length,
                  );
                },
              ),
            ],
          ),
        ));
  }
}
