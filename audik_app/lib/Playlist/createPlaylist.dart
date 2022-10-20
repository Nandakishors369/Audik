import 'dart:ui';

import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import '../Model/playlistmodel.dart';

class AddToPlalistbutton extends StatefulWidget {
  int songindex;
  AddToPlalistbutton({super.key, required this.songindex});

  @override
  State<AddToPlalistbutton> createState() => _AddToPlalistbuttonState();
}

class _AddToPlalistbuttonState extends State<AddToPlalistbutton> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          playlistBottomSheet(context);
          Navigator.pop(context);
        },
        child: Text("Add to Playlist"));
  }

  Future<dynamic> playlistBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setState) => Container(
                  color: Color.fromARGB(255, 0, 0, 0),
                  child: ValueListenableBuilder(
                    valueListenable: playlistbox.listenable(),
                    builder: (context, Box<PlaylistSongs> playlistbox, _) {
                      List<PlaylistSongs> playlist =
                          playlistbox.values.toList();

                      if (playlistbox.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Text(
                                "Create a playlist to add",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          bottomSheet(context),
                                    );
                                  },
                                  child: Text("Create Playlist"))
                            ],
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

                      return Column(
                        children: [
                          Expanded(
                              child: ListView.builder(
                                  itemCount: playlist.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: Icon(
                                        Icons.music_note,
                                        color: Colors.white,
                                      ),
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
                                                dbAllsongs[widget.songindex]
                                                    .id);

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
                                            songurl:
                                                dbAllsongs[widget.songindex]
                                                    .songurl,
                                            id: dbAllsongs[widget.songindex].id,
                                          ));

                                          playlistbox.putAt(
                                              index,
                                              PlaylistSongs(
                                                  playlistname: playlist[index]
                                                      .playlistname,
                                                  playlistssongs: plnewsongs));

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content: Text(
                                                      '${dbAllsongs[widget.songindex].songname}Added to ${playlist[index].playlistname}')));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content: Text(
                                                      '${dbAllsongs[widget.songindex].songname} is already added')));
                                        }
                                        Navigator.pop(context);
                                      },
                                    );
                                  }))
                        ],
                      );
                    },
                  ),
                ));
      },
    );
  }

  //----------------------------------------Function to Create Playlist--------------------------------------------------
  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 423 * 0.7,
      color: Color.fromARGB(255, 24, 24, 24),
      child: Column(
        children: [playlistform(context)],
      ),
    );
  }

  Padding playlistform(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Column(
          children: [
            Text(
              "Create Playlist ",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _textEditingController,
              cursorHeight: 25,
              decoration: InputDecoration(
                  hintText: "enter a name",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 72, 72, 72))),
              validator: (value) {
                List<PlaylistSongs> values = playlistbox.values.toList();

                bool isAlreadyAdded = values
                    .where((element) => element.playlistname == value!.trim())
                    .isNotEmpty;

                if (value!.trim() == '') {
                  return 'Name required';
                }

                if (isAlreadyAdded) {
                  return 'Name Already Exists';
                }
                return null;
              },
            ),
            SizedBox(
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
            child: Text("cancel")),
        ElevatedButton(
            onPressed: () {
              playlistbox.add(PlaylistSongs(
                  playlistname: _textEditingController.text,
                  playlistssongs: []));
              Navigator.pop(context);
            },
            child: Text("Create"))
      ],
    );
  }
}
