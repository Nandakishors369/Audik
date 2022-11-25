/* import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/basic%20operations/songbyalbum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class albumView extends StatefulWidget {
  const albumView({super.key});

  @override
  State<albumView> createState() => _albumViewState();
}

List<AlbumModel> albumList = [];

class _albumViewState extends State<albumView> {
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  OnAudioQuery fetchalbum = OnAudioQuery();
  late int newIndex;
  int count = 0;
  int count1 = 1;

  @override
  void initState() {
    getAlbum();
    super.initState();
  }

  void getAlbum() async {
    albumList = await fetchalbum.queryAlbums();

    for (var items in albumList) {
      albumList.add(items);
    }
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
                        "Playlist",
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
              FutureBuilder<List<AlbumModel>>(
        future: fetchalbum.queryAlbums(),
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
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SizedBox(
              /*  height: height * 0.224, */
              height: 220,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                //scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(19),
                itemBuilder: ((BuildContext context, int index) {
                  final height = MediaQuery.of(context).size.height;
                  final width = MediaQuery.of(context).size.width;
                  return GestureDetector(
                      onTap: () {},
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return SongsByAlbumScreen(
                                albumId: albumList[index].id,
                                albumName: albumList[index].album.toString());
                          }));
                        },
                        leading: const Image(
                          image: AssetImage(
                            "assets/Music Brand and App Logo (1).png",
                          ),
                          height: 32,
                          width: 32,
                        ),
                        title: SingleChildScrollView(
                          child: Text(
                            albumList[index].album.toString(),
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 13.43,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                  
                      );
                }),

                itemCount: albumList.length,
              ),
            ),
          );
        });
            ],
          ),
        ),
      ),
    );
  }

  albumList() {
    
  }
}
 */