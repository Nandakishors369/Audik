import 'package:audik_app/Model/favoriteModel.dart';
import 'package:hive/hive.dart';

late Box<favSongs> favsongsdb;
opendb_fav() async {
  favsongsdb = await Hive.openBox<favSongs>('favsongs');
}
