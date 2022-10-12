import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class addtoFavorites extends StatefulWidget {
  const addtoFavorites({super.key});

  @override
  State<addtoFavorites> createState() => _addtoFavoritesState();
}

class _addtoFavoritesState extends State<addtoFavorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SnackBar(
      content: const Text('Added to  Favorites'),
    )));
  }
}
