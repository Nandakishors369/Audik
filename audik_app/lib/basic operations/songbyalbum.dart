import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Favorite/addtofavorite.dart';
import 'package:audik_app/Main%20Screens/home.dart';
import 'package:audik_app/Model/recentlyplayed_model.dart';
import 'package:audik_app/Playlist/createPlaylist.dart';
import 'package:audik_app/other%20screens/screenplayingnow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:on_audio_query/on_audio_query.dart';

class SongsByArtistScreen extends StatefulWidget {
  final String artistName;
  final int artistId;
  const SongsByArtistScreen(
      {super.key, required this.artistName, required this.artistId});

  @override
  State<SongsByArtistScreen> createState() => _SongsByArtistScreenState();
}

class _SongsByArtistScreenState extends State<SongsByArtistScreen> {
  final OnAudioQuery fetchArtistSongs = OnAudioQuery();
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
                      Text(
                        "${widget.artistName}",
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
              FutureBuilder<List<SongModel>>(
                future: fetchArtistSongs.queryAudiosFrom(
                    AudiosFromType.ALBUM_ID, widget.artistId,
                    sortType: SongSortType.TITLE,
                    orderType: OrderType.ASC_OR_SMALLER),
                builder: (context, item) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10),
                    itemBuilder: (context, index) {
                      List<Audio> songsByArtists = [];
                      for (var songs in item.data!) {
                        itemId = songs.id;
                        songsByArtists.add(Audio.file(songs.uri.toString(),
                            metas: Metas(
                                title: songs.title,
                                artist: songs.artist,
                                id: songs.id.toString())));
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                        child: ListTile(
                          onTap: (() {
                            /* rsongs = RecentPlayed(
                            songname: songs.songname,
                            artist: songs.artist,
                            id: songs.id,
                            duration: songs.duration,
                            songurl: songs.songurl);
                        updateRecentPlayed(rsongs, index);
                        updatePlayedSongCount(MPsongs, index);
                        /* updatePlayedSongCount(MPsongs, index); */ */
                            _audioPlayer.open(
                                Playlist(
                                    audios: songsByArtists, startIndex: index),
                                showNotification: true,
                                headPhoneStrategy:
                                    HeadPhoneStrategy.pauseOnUnplug,
                                loopMode: LoopMode.playlist);
                            setState(() {});
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => playingNow(
                                      index: index,
                                    )),
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
                              songsByArtists[index].metas.title.toString(),
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
                        ),
                      ); /* ListTile(
                    onTap: () {
                      _audioPlayer.open(
                        Playlist(audios: songsByArtists, startIndex: index),
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
                      songsByArtists[index].metas.title.toString(),
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    subtitle: Text(
                      songsByArtists[index].metas.artist.toString(),
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
