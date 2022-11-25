part of 'allsongs_bloc.dart';

@freezed
class AllsongsState with _$AllsongsState {
  const factory AllsongsState({required List<Songs> allDbSongs}) =
      _AllsongsState;

  factory AllsongsState.initial() =>
      AllsongsState(allDbSongs: SongBox.getInstance().values.toList());
}
