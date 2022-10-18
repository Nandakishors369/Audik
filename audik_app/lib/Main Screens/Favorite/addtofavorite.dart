import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/favoriteModel.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class addToFavorite extends StatefulWidget {
  int index;
  addToFavorite({super.key, required this.index});

  @override
  State<addToFavorite> createState() => _addToFavoriteState();
}

class _addToFavoriteState extends State<addToFavorite> {
  List<favSongs> fav = [];
  bool favorited = false;
  final box = SongBox.getInstance();
  late List<Songs> dbsongs;
  @override
  void initState() {
    // TODO: implement initState
    dbsongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fav = favsongsdb.values.toList();
    return Scaffold();
  }
}
