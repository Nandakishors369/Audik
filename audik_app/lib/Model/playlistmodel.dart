import 'package:audik_app/Model/songModel.dart';
import 'package:hive/hive.dart';
part 'playlistmodel.g.dart';

@HiveType(typeId: 2)
class PlaylistSongs {
  @HiveField(0)
  String? playlistname;
  @HiveField(1)
  List<Songs>? playlistssongs;

  PlaylistSongs({required this.playlistname, required this.playlistssongs});
}
