// ignore_for_file: camel_case_types, must_be_immutable, use_build_context_synchronously

import 'package:audik_app/Bloc/bloc/favorites_bloc.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/favoriteModel.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    dbsongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fav = favsongsdb.values.toList();
    return fav
            .where(
                (element) => element.songname == dbsongs[widget.index].songname)
            .isEmpty
        ? TextButton(
            onPressed: () {
              BlocProvider.of<FavoritesBloc>(context)
                  .add(FavoritesEvent.started());
              favsongsdb.add(favSongs(
                  songname: dbsongs[widget.index].songname,
                  artist: dbsongs[widget.index].artist,
                  duration: dbsongs[widget.index].duration,
                  songurl: dbsongs[widget.index].songurl,
                  id: dbsongs[widget.index].id));
              setState(() {});
              BlocProvider.of<FavoritesBloc>(context)
                  .add(FavoritesEvent.started());
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Favorites")));
            },
            child: const Text("Add to Favorites"))
        : TextButton(
            onPressed: () async {
              BlocProvider.of<FavoritesBloc>(context)
                  .add(FavoritesEvent.started());
              if (favsongsdb.length < 1) {
                favsongsdb.clear();
                BlocProvider.of<FavoritesBloc>(context)
                    .add(FavoritesEvent.started());
                setState(() {});
              } else {
                int currentIndex = fav.indexWhere(
                    (element) => element.id == dbsongs[widget.index].id);
                await favsongsdb.deleteAt(currentIndex);
                setState(() {});
                BlocProvider.of<FavoritesBloc>(context)
                    .add(FavoritesEvent.started());

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Removed From Favorites")));
              }
              BlocProvider.of<FavoritesBloc>(context)
                  .add(FavoritesEvent.started());
            },
            child: const Text("Remove From Favorites"));
  }
}
