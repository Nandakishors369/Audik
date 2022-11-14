// ignore: file_names
// ignore_for_file: must_be_immutable, file_names, duplicate_ignore, prefer_final_fields

import 'package:audik_app/Model/dbfunctions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import '../Model/playlistmodel.dart';
import '../Model/songModel.dart';

class PlayScreenPlst extends StatefulWidget {
  int songindex;
  PlayScreenPlst({super.key, required this.songindex});

  @override
  State<PlayScreenPlst> createState() => _PlayScreenPlstState();
}

class _PlayScreenPlstState extends State<PlayScreenPlst> {
  TextEditingController _textEditingController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await playlistBottomSheet(context);

          //Navigator.pop(context);
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ));
  }

  Future<dynamic> playlistBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setState) => Container(
                  height: 200,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  child: ValueListenableBuilder(
                    valueListenable: playlistbox.listenable(),
                    builder: (context, Box<PlaylistSongs> playlistbox, _) {
                      List<PlaylistSongs> playlist =
                          playlistbox.values.toList();

                      if (playlistbox.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Create a playlist to add",
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) =>
                                            bottomSheet(context),
                                      );
                                    },
                                    child: const Text("Create Playlist"))
                              ],
                            ),
                          ),
                        );
                      }
                      //----------------------------------------Add to playlist--------------------------------------------------
/*                       return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return ListTile(
                                    title: Text(
                                      playlist[index].playlistname.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      PlaylistSongs? plsongs =
                                          playlistbox.getAt(index);
                                      List<Songs>? plnewsongs =
                                          plsongs!.playlistssongs;
                                      Box<Songs> box = Hive.box('Songs');
                                      List<Songs> dbAllsongs =
                                          box.values.toList();
                                      bool isAlreadyAdded = plnewsongs!.any(
                                          (element) =>
                                              element.id ==
                                              dbAllsongs[widget.songindex].id);
                                      if (!isAlreadyAdded) {
                                        plnewsongs.add(Songs(
                                            songname:
                                                dbAllsongs[widget.songindex]
                                                    .songname,
                                            artist: dbAllsongs[widget.songindex]
                                                .artist,
                                            duration:
                                                dbAllsongs[widget.songindex]
                                                    .duration,
                                            id: dbAllsongs[widget.songindex].id,
                                            songurl:
                                                dbAllsongs[widget.songindex]
                                                    .songurl));
                                        playlistbox.putAt(
                                            index,
                                            PlaylistSongs(
                                                playlistname:
                                                    playlist[index].toString(),
                                                playlistssongs: plnewsongs));

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.black,
                                                content: Text(
                                                  '${dbAllsongs[widget.songindex].songname}Added to ${playlist[index].playlistname}',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )));
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.black,
                                                content: Text(
                                                  '${dbAllsongs[widget.songindex].songname} is already added',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )));
                                      }
                                      Navigator.pop(context);
                                    });
                              },
                              itemCount: playlist.length,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ));
      },
    );
  } */

                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Text(
                              "Your Playlists",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22)),
                            ),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: playlist.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: const Icon(
                                          Icons.music_note,
                                          color: Colors.white,
                                        ),
                                        title: Text(
                                          playlist[index]
                                              .playlistname
                                              .toString(),
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        onTap: () {
                                          PlaylistSongs? plsongs =
                                              playlistbox.getAt(index);
                                          List<Songs>? plnewsongs =
                                              plsongs!.playlistssongs;
                                          Box<Songs> box = Hive.box('Songs');
                                          List<Songs> dbAllsongs =
                                              box.values.toList();
                                          bool isAlreadyAdded = plnewsongs!.any(
                                              (element) =>
                                                  element.id ==
                                                  dbAllsongs[widget.songindex]
                                                      .id);

                                          if (!isAlreadyAdded) {
                                            plnewsongs.add(Songs(
                                              songname:
                                                  dbAllsongs[widget.songindex]
                                                      .songname,
                                              artist:
                                                  dbAllsongs[widget.songindex]
                                                      .artist,
                                              duration:
                                                  dbAllsongs[widget.songindex]
                                                      .duration,
                                              songurl:
                                                  dbAllsongs[widget.songindex]
                                                      .songurl,
                                              id: dbAllsongs[widget.songindex]
                                                  .id,
                                            ));

                                            playlistbox.putAt(
                                                index,
                                                PlaylistSongs(
                                                    playlistname:
                                                        playlist[index]
                                                            .playlistname,
                                                    playlistssongs:
                                                        plnewsongs));

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    content: Text(
                                                        '${dbAllsongs[widget.songindex].songname}Added to ${playlist[index].playlistname}')));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    content: Text(
                                                        '${dbAllsongs[widget.songindex].songname} is already added')));
                                          }
                                          Navigator.pop(context);
                                        },
                                      );
                                    }))
                          ],
                        ),
                      );
                    },
                  ),
                ));
      },
    );
  }

  //----------------------------------------Function to Create Playlist--------------------------------------------------
  Widget bottomSheet(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 250,
        color: const Color.fromARGB(255, 24, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [playlistform(context)],
        ),
      ),
    );
  }

  Padding playlistform(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        child: Column(
          children: [
            Text(
              "Create Playlist ",
              style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formGlobalKey,
              child: TextFormField(
                controller: _textEditingController,
                cursorHeight: 25,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(199, 255, 255, 255),
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
                  hintText: "Enter a name",
                  hintStyle: GoogleFonts.montserrat(
                      textStyle:
                          const TextStyle(color: Color.fromARGB(255, 69, 69, 69))),
                ),
                validator: (value) {
                  List<PlaylistSongs> values = playlistbox.values.toList();

                  bool isAlreadyAdded = values
                      .where((element) => element.playlistname == value!.trim())
                      .isNotEmpty;

                  if (value!.trim() == '') {
                    return 'Name required';
                  }
                  if (value.trim().length > 10) {
                    return 'Enter Characters below 10 ';
                  }

                  if (isAlreadyAdded) {
                    return 'Name Already Exists';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            formButtons(context)
          ],
        ),
      ),
    );
  }

  Row formButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        ElevatedButton(
            onPressed: () {
              final isValid = formGlobalKey.currentState!.validate();
              if (isValid) {
                playlistbox.add(PlaylistSongs(
                    playlistname: _textEditingController.text,
                    playlistssongs: []));
                Navigator.pop(context);
              }
            },
            child: const Text("Create"))
      ],
    );
  }
}
