part of 'recently_played_bloc.dart';

//late Box<RecentPlayed> recedntsongs;
@freezed
class RecentlyPlayedState with _$RecentlyPlayedState {
  const factory RecentlyPlayedState({required List<RecentPlayed> recent}) =
      _RecentlyPlayedState;
  factory RecentlyPlayedState.initial() => RecentlyPlayedState(
      recent: recentlyplayedbox.values.toList().reversed.toList());
}
