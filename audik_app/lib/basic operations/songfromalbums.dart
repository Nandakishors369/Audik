import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/basic%20operations/songbyalbum.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Artist extends StatefulWidget {
  const Artist({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<Artist> createState() => _ArtistState();
}

List<AlbumModel> artistList = [];

class _ArtistState extends State<Artist> {
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  OnAudioQuery fetchartist = OnAudioQuery();
  late int newIndex;
  int count = 0;
  int count1 = 1;

  @override
  void initState() {
    getArtist();
    super.initState();
  }

  void getArtist() async {
    artistList = await fetchartist.queryAlbums();

    for (var items in artistList) {
      artistList.add(items);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<AlbumModel>>(
        future: fetchartist.queryAlbums(),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (item.data!.isEmpty) {
            return Center(
              child: Text('No Album Found!',
                  style: TextStyle(color: Colors.white)),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: [
                    Text(
                      "Your Albums",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: width * 0.0543,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  /*  height: height * 0.224, */
                  height: 220,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(19),
                    itemBuilder: ((BuildContext context, int index) {
                      final height = MediaQuery.of(context).size.height;
                      final width = MediaQuery.of(context).size.width;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return SongsByArtistScreen(
                                artistId: artistList[index].id,
                                artistName:
                                    artistList[index].artist.toString());
                          }));
                          /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const ScreenPlaylist()),
                    ),
                  ); */
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.0106, 0, 0),
                              child: QueryArtworkWidget(
                                artworkHeight: width * 0.306,
                                artworkWidth: width * 0.306,
                                artworkFit: BoxFit.cover,
                                id: artistList[index].id,
                                type: ArtworkType.AUDIO,
                                artworkQuality: FilterQuality.high,
                                size: 2000,
                                quality: 100,
                                artworkBorder: BorderRadius.circular(8),
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  child: Image.asset(
                                    'assets/Music Brand and App Logo (1).png',
                                    height: width * 0.306,
                                    width: width * 0.306,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 18,
                              width: width * .28,
                              child: Marquee(
                                blankSpace: 20,
                                velocity: 20,
                                text: artistList[index].artist.toString(),
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                    separatorBuilder: ((context, index) {
                      return SizedBox(
                        width: width * 0.024,
                      );
                    }),
                    itemCount: artistList.length,
                  ),
                ),
              ),
            ],
          );
        });
  }
}



/* GridView.builder(
            padding: EdgeInsets.only(top: 10, bottom: 0),
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (1),
            ),
            itemCount: artistList.length - 1,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SongsByArtistScreen(
                          artistId: artistList[index].id,
                          artistName: artistList[index].artist.toString());
                    }));
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/Music Brand and App Logo (1).png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  artistList[index].artist.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Songs   ',
                  style: TextStyle(color: Colors.white),
                ),
              ]);
            }); */