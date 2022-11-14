// ignore_for_file: file_names, must_be_immutable, avoid_print, use_build_context_synchronously


import 'package:audik_app/Model/dbfunctions.dart';
import 'package:flutter/material.dart';

import '../Model/favoriteModel.dart';
import '../Model/songModel.dart';

class PlayScreenFav extends StatefulWidget {
  int index;
  PlayScreenFav({super.key, required this.index});

  @override
  State<PlayScreenFav> createState() => _PlayScreenFavState();
}

class _PlayScreenFavState extends State<PlayScreenFav> {
  List<favSongs> fav = [];
  bool favorited = false;
  final box = SongBox.getInstance();

  late List<Songs> dbsongs = box.values.toList();
  @override
  void initState() {
   
    dbsongs = box.values.toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fav = favsongsdb.values.toList();
    //print("daaa");

   print(dbsongs[widget.index].songname);
    return fav
            .where(
                (element) => element.songname == dbsongs[widget.index].songname)
            .isEmpty
        ? IconButton(
            onPressed: () {
              favsongsdb.add(favSongs(
                  songname: dbsongs[widget.index].songname,
                  artist: dbsongs[widget.index].artist,
                  duration: dbsongs[widget.index].duration,
                  songurl: dbsongs[widget.index].songurl,
                  id: dbsongs[widget.index].id));
              setState(() {});
              //Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Added to Favorites")));
            },
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
            ))
        : IconButton(
            onPressed: () async {
              if (favsongsdb.length < 1) {
                favsongsdb.clear();
                setState(() {});
              } else {
                int currentIndex = fav.indexWhere(
                    (element) => element.id == dbsongs[widget.index].id);
                await favsongsdb.deleteAt(currentIndex);
                setState(() {});
                // Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Removed From Favorites")));
              }
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ));
  }
}
