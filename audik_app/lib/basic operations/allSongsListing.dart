import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({super.key});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    songName() async {
      print("thudangi");
      List<SongModel> songlisting = await _audioQuery.querySongs();
      print("kayinj");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      ),
      builder: ((context, item) {
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (item.data!.isEmpty) {
          return const Center(
            child: Text("No songs Found"),
          );
        }
        return Container(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: item.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(item.data![index].displayNameWOExt),
                  subtitle: Text("${item.data![index].artist}"),
                  trailing: Icon(Icons.more_vert),
                  leading: QueryArtworkWidget(
                      id: item.data![index].id, type: ArtworkType.AUDIO),
                );
              }),
        );
      }),
    );
  }
}
