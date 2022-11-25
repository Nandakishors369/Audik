// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'allsongs_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AllsongsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() onTap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? onTap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? onTap,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_OnTap value) onTap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_OnTap value)? onTap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_OnTap value)? onTap,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllsongsEventCopyWith<$Res> {
  factory $AllsongsEventCopyWith(
          AllsongsEvent value, $Res Function(AllsongsEvent) then) =
      _$AllsongsEventCopyWithImpl<$Res, AllsongsEvent>;
}

/// @nodoc
class _$AllsongsEventCopyWithImpl<$Res, $Val extends AllsongsEvent>
    implements $AllsongsEventCopyWith<$Res> {
  _$AllsongsEventCopyWithImpl(this._value, this._then);

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
    extends _$AllsongsEventCopyWithImpl<$Res, _$_Started>
    implements _$$_StartedCopyWith<$Res> {
  __$$_StartedCopyWithImpl(_$_Started _value, $Res Function(_$_Started) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Started implements _Started {
  const _$_Started();

  @override
  String toString() {
    return 'AllsongsEvent.started()';
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
    required TResult Function() onTap,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? onTap,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? onTap,
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
    required TResult Function(_OnTap value) onTap,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_OnTap value)? onTap,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_OnTap value)? onTap,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements AllsongsEvent {
  const factory _Started() = _$_Started;
}

/// @nodoc
abstract class _$$_OnTapCopyWith<$Res> {
  factory _$$_OnTapCopyWith(_$_OnTap value, $Res Function(_$_OnTap) then) =
      __$$_OnTapCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_OnTapCopyWithImpl<$Res>
    extends _$AllsongsEventCopyWithImpl<$Res, _$_OnTap>
    implements _$$_OnTapCopyWith<$Res> {
  __$$_OnTapCopyWithImpl(_$_OnTap _value, $Res Function(_$_OnTap) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_OnTap implements _OnTap {
  const _$_OnTap();

  @override
  String toString() {
    return 'AllsongsEvent.onTap()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_OnTap);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() onTap,
  }) {
    return onTap();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? onTap,
  }) {
    return onTap?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? onTap,
    required TResult orElse(),
  }) {
    if (onTap != null) {
      return onTap();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_OnTap value) onTap,
  }) {
    return onTap(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_OnTap value)? onTap,
  }) {
    return onTap?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_OnTap value)? onTap,
    required TResult orElse(),
  }) {
    if (onTap != null) {
      return onTap(this);
    }
    return orElse();
  }
}

abstract class _OnTap implements AllsongsEvent {
  const factory _OnTap() = _$_OnTap;
}

/// @nodoc
mixin _$AllsongsState {
  List<Songs> get allDbSongs => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AllsongsStateCopyWith<AllsongsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllsongsStateCopyWith<$Res> {
  factory $AllsongsStateCopyWith(
          AllsongsState value, $Res Function(AllsongsState) then) =
      _$AllsongsStateCopyWithImpl<$Res, AllsongsState>;
  @useResult
  $Res call({List<Songs> allDbSongs});
}

/// @nodoc
class _$AllsongsStateCopyWithImpl<$Res, $Val extends AllsongsState>
    implements $AllsongsStateCopyWith<$Res> {
  _$AllsongsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allDbSongs = null,
  }) {
    return _then(_value.copyWith(
      allDbSongs: null == allDbSongs
          ? _value.allDbSongs
          : allDbSongs // ignore: cast_nullable_to_non_nullable
              as List<Songs>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AllsongsStateCopyWith<$Res>
    implements $AllsongsStateCopyWith<$Res> {
  factory _$$_AllsongsStateCopyWith(
          _$_AllsongsState value, $Res Function(_$_AllsongsState) then) =
      __$$_AllsongsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Songs> allDbSongs});
}

/// @nodoc
class __$$_AllsongsStateCopyWithImpl<$Res>
    extends _$AllsongsStateCopyWithImpl<$Res, _$_AllsongsState>
    implements _$$_AllsongsStateCopyWith<$Res> {
  __$$_AllsongsStateCopyWithImpl(
      _$_AllsongsState _value, $Res Function(_$_AllsongsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allDbSongs = null,
  }) {
    return _then(_$_AllsongsState(
      allDbSongs: null == allDbSongs
          ? _value._allDbSongs
          : allDbSongs // ignore: cast_nullable_to_non_nullable
              as List<Songs>,
    ));
  }
}

/// @nodoc

class _$_AllsongsState implements _AllsongsState {
  const _$_AllsongsState({required final List<Songs> allDbSongs})
      : _allDbSongs = allDbSongs;

  final List<Songs> _allDbSongs;
  @override
  List<Songs> get allDbSongs {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allDbSongs);
  }

  @override
  String toString() {
    return 'AllsongsState(allDbSongs: $allDbSongs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AllsongsState &&
            const DeepCollectionEquality()
                .equals(other._allDbSongs, _allDbSongs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allDbSongs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AllsongsStateCopyWith<_$_AllsongsState> get copyWith =>
      __$$_AllsongsStateCopyWithImpl<_$_AllsongsState>(this, _$identity);
}

abstract class _AllsongsState implements AllsongsState {
  const factory _AllsongsState({required final List<Songs> allDbSongs}) =
      _$_AllsongsState;

  @override
  List<Songs> get allDbSongs;
  @override
  @JsonKey(ignore: true)
  _$$_AllsongsStateCopyWith<_$_AllsongsState> get copyWith =>
      throw _privateConstructorUsedError;
}
