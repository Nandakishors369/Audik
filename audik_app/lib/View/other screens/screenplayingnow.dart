// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Bloc/Recently%20Played/recently_played_bloc.dart';
import 'package:audik_app/Bloc/now%20playing/now_playing_bloc.dart';
import 'package:audik_app/View/Favorite/addtoFavoritePlayScreen.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/mostlyplayed_model.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:audik_app/View/Playlist/AddToPlaylistPlay.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../Model/recentlyplayed_model.dart';

class playingNow extends StatelessWidget {
  playingNow({
    super.key,
  });

  final player = AssetsAudioPlayer.withId('0');

  Duration duration = Duration.zero;

  Duration position = Duration.zero;

  bool isRepeat = false;

  bool isShuffle = true;

  late List<Songs> dbsongs = box.values.toList();

  final box = SongBox.getInstance();

  List<MostPlayed> allmostplayedsongs = mostplayedsongs.values.toList();

  // @override
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return player.builderCurrent(
      builder: (context, playing) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 21, 21, 21),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: height * .096,
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
                            "Now Playing",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        player.builderCurrent(
                          builder: (context, playing) {
                            return PlayScreenFav(
                              index: dbsongs.indexWhere((element) =>
                                  element.songname ==
                                  playing.audio.audio.metas.title),
                            );
                          },
                        ),
                        SizedBox(
                          width: width * 0.10625,
                        ),
                        SizedBox(
                          width: width * 0.10625,
                        ),
                        PlayScreenPlst(songindex: playing.index)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: width * 0.7556,
                    width: width * 0.7556,
                    child: QueryArtworkWidget(
                      artworkFit: BoxFit.contain,
                      artworkBorder: BorderRadius.circular(8),
                      artworkHeight: width * 0.7556,
                      artworkWidth: width * 0.7556,
                      id: int.parse(playing.audio.audio.metas.id!),
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/Music Brand and App Logo (1).png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Column(
                      children: [
                        SizedBox(height: height * .02),
                        SizedBox(
                          height: height * .03,
                          width: width,
                          child: Marquee(
                            blankSpace: 20,
                            velocity: 20,
                            text: player.getCurrentAudioTitle,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .03,
                          width: width * .2,
                          child: Marquee(
                            blankSpace: 20,
                            velocity: 20,
                            text: player.getCurrentAudioArtist,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.00531,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: PlayerBuilder.realtimePlayingInfos(
                      player: player,
                      builder: (context, realtimePlayingInfos) {
                        final duration =
                            realtimePlayingInfos.current!.audio.duration;

                        final position = realtimePlayingInfos.currentPosition;
                        return ProgressBar(
                          progress: position,
                          total: duration,
                          timeLabelPadding: 15,
                          timeLabelTextStyle:
                              const TextStyle(color: Colors.white),
                          onSeek: (duration) => player.seek(duration),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.00520,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PlayerBuilder.isPlaying(
                          player: player,
                          builder: (context, isPlaying) {
                            return IconButton(
                              onPressed: () async {
                                await player.previous();

                                if (isPlaying == false) {
                                  player.pause();
                                }
                              },
                              icon: const Icon(Icons.skip_previous),
                              color: Colors.white,
                              iconSize: 45,
                            );
                          },
                        ),
                        IconButton(
                          onPressed: () async {
                            await player.seekBy(const Duration(seconds: -10));
                          },
                          icon: const Icon(Icons.replay_10),
                          color: Colors.white,
                          iconSize: 30,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: PlayerBuilder.isPlaying(
                              player: player,
                              builder: (context, isPlaying) {
                                return IconButton(
                                  onPressed: () {
                                    player.playOrPause();
                                  },
                                  icon: Icon(isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow),
                                  iconSize: 50,
                                  color: Colors.white,
                                );
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await player.seekBy(const Duration(seconds: 10));
                          },
                          icon: const Icon(Icons.forward_10),
                          color: Colors.white,
                          iconSize: 30,
                        ),
                        PlayerBuilder.isPlaying(
                          player: player,
                          builder: (context, isPlaying) {
                            return IconButton(
                              onPressed: () async {
                                await player.next();

                                RecentPlayed rsongs;
                                MostPlayed MPsongs =
                                    allmostplayedsongs[playing.index];
                                rsongs = RecentPlayed(
                                    songname:
                                        dbsongs[playing.index + 1].songname,
                                    artist: dbsongs[playing.index + 1].artist,
                                    id: dbsongs[playing.index + 1].id,
                                    duration:
                                        dbsongs[playing.index + 1].duration,
                                    songurl:
                                        dbsongs[playing.index + 1].songurl);
                                updateRecentPlayed(rsongs, playing.index + 1);
                                BlocProvider.of<RecentlyPlayedBloc>(context)
                                    .add(RecentlyPlayedEvent.started());
                                updatePlayedSongCount(
                                    MPsongs, playing.index + 1);
                                if (isPlaying == false) {
                                  player.pause();
                                }
                              },
                              icon: const Icon(Icons.skip_next),
                              color: Colors.white,
                              iconSize: 45,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<NowPlayingBloc, NowPlayingState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (isRepeat) {
                                  player.setLoopMode(LoopMode.none);
                                  context.read<NowPlayingBloc>().add(
                                        const NowPlayingEvent.untapped(),
                                      );
                                  isRepeat = false;
                                } else {
                                  player.setLoopMode(LoopMode.single);
                                  context.read<NowPlayingBloc>().add(
                                        const NowPlayingEvent.tapped(),
                                      );
                                  isRepeat = true;
                                }
                                //setState(() {});
                              },
                              icon: Icon(Icons.repeat, color: state.loop),
                            ),
                            const SizedBox(
                              width: 45,
                            ),
                            const SizedBox(
                              width: 45,
                            ),
                            IconButton(
                              onPressed: () {
                                if (isShuffle) {
                                  player.toggleShuffle();
                                  context.read<NowPlayingBloc>().add(
                                        const NowPlayingEvent.ontaped(),
                                      );
                                  isShuffle = false;
                                } else {
                                  player.toggleShuffle();
                                  context.read<NowPlayingBloc>().add(
                                        const NowPlayingEvent.untap(),
                                      );
                                  isShuffle = true;
                                }
                              },
                              icon: Icon(
                                Icons.shuffle,
                                color: state.shuffle,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
