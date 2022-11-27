// ignore_for_file: file_names, unused_local_variable, non_constant_identifier_names, must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Bloc/All%20Songs/allsongs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/mostlyplayed_model.dart';
import 'package:audik_app/Model/recentlyplayed_model.dart';
import 'package:audik_app/View/Playlist/createPlaylist.dart';
import 'package:audik_app/View/other%20screens/setting.dart';

import '../../Model/songModel.dart';
import '../Favorite/addtofavorite.dart';
import '../other screens/screenplayingnow.dart';

// ignore: camel_case_types
class allSongsScreen extends StatelessWidget {
  allSongsScreen({super.key});

  late bool isplaying;

  late bool playerVisibility;

  final box = SongBox.getInstance();

  List<Audio> convertAudios = [];

  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<AllsongsBloc, AllsongsState>(
      builder: (context, state) {
        List<MostPlayed> allmostplayedsongs = mostplayedsongs.values.toList();
        //----------------------------------------If songs are not there--------------------------------------------------
        if (state.allDbSongs.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        //----------------------------------------If the list is null--------------------------------------------------
        if (state.allDbSongs == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        //----------------------------------------Showing songs in list tile--------------------------------------------------

        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.allDbSongs.length,
            itemBuilder: (context, index) {
              Songs songs = state.allDbSongs[index];
              RecentPlayed rsongs;
              MostPlayed MPsongs = allmostplayedsongs[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                child: ListTile(
                  onTap: (() {
                    playerOnTap();
                    rsongs = RecentPlayed(
                        songname: songs.songname,
                        artist: songs.artist,
                        id: songs.id,
                        duration: songs.duration,
                        songurl: songs.songurl);
                    updateRecentPlayed(rsongs, index);
                    updatePlayedSongCount(MPsongs, index);

                    _audioPlayer.open(
                        Playlist(audios: convertAudios, startIndex: index),
                        showNotification: musicNotif,
                        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
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
                    id: state.allDbSongs[index].id!,
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
                    state.allDbSongs[index].songname!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 13.43,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
                  //----------------------------------------Trailing Menu Pop UP--------------------------------------------------
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
                                //----------------------------------------Add to Playlist--------------------------------------------------
                                AddToPlalistbutton(songindex: index),
                                SizedBox(
                                  height: height * 0.011,
                                ),
                                //----------------------------------------Add to Favorite--------------------------------------------------
                                addToFavorite(
                                  index: index,
                                ),
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
      },
    );
  }

  playerOnTap() {
    List<Songs> dbsongs = SongBox.getInstance().values.toList();
    for (var item in dbsongs) {
      convertAudios.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }
  }
}
