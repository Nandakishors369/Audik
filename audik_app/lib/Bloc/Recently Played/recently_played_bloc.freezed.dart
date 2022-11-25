// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'recently_played_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecentlyPlayedEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentlyPlayedEventCopyWith<$Res> {
  factory $RecentlyPlayedEventCopyWith(
          RecentlyPlayedEvent value, $Res Function(RecentlyPlayedEvent) then) =
      _$RecentlyPlayedEventCopyWithImpl<$Res, RecentlyPlayedEvent>;
}

/// @nodoc
class _$RecentlyPlayedEventCopyWithImpl<$Res, $Val extends RecentlyPlayedEvent>
    implements $RecentlyPlayedEventCopyWith<$Res> {
  _$RecentlyPlayedEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_StartedCopyWith<$Res> {
  factory _$$_StartedCopyWith(
          _$_Started value, $Res Function(_$_Started) then) =
      __$$_StartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_StartedCopyWithImpl<$Res>
    extends _$RecentlyPlayedEventCopyWithImpl<$Res, _$_Started>
    implements _$$_StartedCopyWith<$Res> {
  __$$_StartedCopyWithImpl(_$_Started _value, $Res Function(_$_Started) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Started implements _Started {
  const _$_Started();

  @override
  String toString() {
    return 'RecentlyPlayedEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements RecentlyPlayedEvent {
  const factory _Started() = _$_Started;
}

/// @nodoc
mixin _$RecentlyPlayedState {
  List<RecentPlayed> get recent => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecentlyPlayedStateCopyWith<RecentlyPlayedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentlyPlayedStateCopyWith<$Res> {
  factory $RecentlyPlayedStateCopyWith(
          RecentlyPlayedState value, $Res Function(RecentlyPlayedState) then) =
      _$RecentlyPlayedStateCopyWithImpl<$Res, RecentlyPlayedState>;
  @useResult
  $Res call({List<RecentPlayed> recent});
}

/// @nodoc
class _$RecentlyPlayedStateCopyWithImpl<$Res, $Val extends RecentlyPlayedState>
    implements $RecentlyPlayedStateCopyWith<$Res> {
  _$RecentlyPlayedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recent = null,
  }) {
    return _then(_value.copyWith(
      recent: null == recent
          ? _value.recent
          : recent // ignore: cast_nullable_to_non_nullable
              as List<RecentPlayed>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecentlyPlayedStateCopyWith<$Res>
    implements $RecentlyPlayedStateCopyWith<$Res> {
  factory _$$_RecentlyPlayedStateCopyWith(_$_RecentlyPlayedState value,
          $Res Function(_$_RecentlyPlayedState) then) =
      __$$_RecentlyPlayedStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<RecentPlayed> recent});
}

/// @nodoc
class __$$_RecentlyPlayedStateCopyWithImpl<$Res>
    extends _$RecentlyPlayedStateCopyWithImpl<$Res, _$_RecentlyPlayedState>
    implements _$$_RecentlyPlayedStateCopyWith<$Res> {
  __$$_RecentlyPlayedStateCopyWithImpl(_$_RecentlyPlayedState _value,
      $Res Function(_$_RecentlyPlayedState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recent = null,
  }) {
    return _then(_$_RecentlyPlayedState(
      recent: null == recent
          ? _value._recent
          : recent // ignore: cast_nullable_to_non_nullable
              as List<RecentPlayed>,
    ));
  }
}

/// @nodoc

class _$_RecentlyPlayedState implements _RecentlyPlayedState {
  const _$_RecentlyPlayedState({required final List<RecentPlayed> recent})
      : _recent = recent;

  final List<RecentPlayed> _recent;
  @override
  List<RecentPlayed> get recent {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recent);
  }

  @override
  String toString() {
    return 'RecentlyPlayedState(recent: $recent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecentlyPlayedState &&
            const DeepCollectionEquality().equals(other._recent, _recent));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_recent));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecentlyPlayedStateCopyWith<_$_RecentlyPlayedState> get copyWith =>
      __$$_RecentlyPlayedStateCopyWithImpl<_$_RecentlyPlayedState>(
          this, _$identity);
}

abstract class _RecentlyPlayedState implements RecentlyPlayedState {
  const factory _RecentlyPlayedState(
      {required final List<RecentPlayed> recent}) = _$_RecentlyPlayedState;

  @override
  List<RecentPlayed> get recent;
  @override
  @JsonKey(ignore: true)
  _$$_RecentlyPlayedStateCopyWith<_$_RecentlyPlayedState> get copyWith =>
      throw _privateConstructorUsedError;
}
