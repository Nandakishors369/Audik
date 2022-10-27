import 'package:audik_app/Model/favoriteModel.dart';
import 'package:audik_app/Model/mostlyplayed_model.dart';
import 'package:audik_app/Model/playlistmodel.dart';
import 'package:audik_app/Model/recentlyplayed_model.dart';
import 'package:hive/hive.dart';

late Box<favSongs> favsongsdb;
opendb_fav() async {
  favsongsdb = await Hive.openBox<favSongs>('favsongs');
}

late Box<PlaylistSongs> playlistbox;
opendatabase() async {
  playlistbox = await Hive.openBox<PlaylistSongs>('playlist');
}

late Box<MostPlayed> mostplayedsongs;
openmostplayeddb() async {
  mostplayedsongs = await Hive.openBox("mostlyplayed");
}

updatePlayedSongCount(MostPlayed value, int index) {
  int count = value.count;
  value.count = count + 1;
  mostplayedsongs.put(index, value);
  print("this song now played ${value.count}");
}

late Box<RecentPlayed> recentlyplayedbox;
openrecentlyplayedDb() async {
  recentlyplayedbox = await Hive.openBox('recentlyplayed');
}

/* updateRecentPlayed(RecentPlayed value) {
  List<RecentPlayed> list = recentlyplayedbox.values.toList();
  bool isAlready =
      list.where((element) => element.songname == value.songname).isEmpty;

  if (isAlready == true) {
    recentlyplayedbox.add(value);
  }
} */
updateRecentPlayed(RecentPlayed value, index) {
  List<RecentPlayed> list = recentlyplayedbox.values.toList();
  bool isAlready =
      list.where((element) => element.songname == value.songname).isEmpty;

  if (isAlready == true) {
    recentlyplayedbox.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    recentlyplayedbox.deleteAt(index);
    recentlyplayedbox.add(value);
  }
}
