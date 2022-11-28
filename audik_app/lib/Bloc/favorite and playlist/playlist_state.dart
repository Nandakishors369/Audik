part of 'playlist_bloc.dart';

@freezed
class PlaylistState with _$PlaylistState {
  const factory PlaylistState({required List<PlaylistSongs> playylist}) =
      _PlaylistState;
  factory PlaylistState.initial() =>
      PlaylistState(playylist: playlistbox.values.toList());
}
