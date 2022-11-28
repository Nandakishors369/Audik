part of 'favorites_bloc.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState({required List<favSongs> fav}) = _FavoritesState;

  factory FavoritesState.initial() =>
      FavoritesState(fav: favsongsdb.values.toList());
}
